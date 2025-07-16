Return-Path: <linux-kernel+bounces-733840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC7B079B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A93A43F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938E28643D;
	Wed, 16 Jul 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="M8BB3X+F"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E11E0E14
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679369; cv=none; b=QmSk0G2M4tXAvpQDLC+sK+Kj5upcegDsIfacVGgJjHlq/DjxAjfBKkxG5FVyhUSFYbP9Ph2iPX2msg5CtORrVE21ng7n9QobAOoDAvfZwelDQizNZAUDtRfaoJC6kj+lYzcFdzkpCXgEHhHxFjsb0SoXl6S5AMbHSOFmQfgab4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679369; c=relaxed/simple;
	bh=06qVea3kBdVTlMvKU0MAOweuO+1RupDtDA0/7gEsO44=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=UOTHW8OVx1nv178SVIq84wm+JJOFR+LCeSXcT7XijjR74HpgyA01nB9W8OVySN8BDiuW4ajushuJ81UGeqQb5H7RVBZvftL38aEVW2H1ezifG8vFi4/VwchGxztcNI1tDf1bM7PNxLxepo7UR6uqn0ihn8oDovKNJo2C1PW6xsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=M8BB3X+F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349f096605so85669045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752679365; x=1753284165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4vl3Ek2bHdxNr4E5QFSQW0xOn72vkMZt86TovXCUIE=;
        b=M8BB3X+FXAkJU7kpHWxgIUPGcFTLY7/eUEFOvOmUmxrouC67tJ2RdGG95+5ikxei1r
         3rNvuTjjDqliYmGvWV3sXoEhjghaCCDtRuuROfz5hJvEN6o/c4gbmHwNEPPxYvtFZW20
         1LmsbZRupMg09KcGJK9sENc0wxB2lvOdXw3OWughukX8CSUli/E1IADyZBTHTZygh4gR
         SX/I0UBXYb1qILP4nDK2xFvbDiqoIIPVScyYsxSy6vhAtyPF4mdx7Y6s//bUaD4xOQb/
         iilGUPo1v8wUBdAtY2zY5wQpGFVIH0+8BmkJKXBeK1b3Tleq3dZ8W4j/n5H5gY7U4zNT
         FCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679365; x=1753284165;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4vl3Ek2bHdxNr4E5QFSQW0xOn72vkMZt86TovXCUIE=;
        b=SuB1MUxTtkuPPciSncTKvVISPxmXMyVPmpcEi6Plmj19oB0e2+WV1aEqG+u4wIlX22
         sp/0XD9klWk6U4gsetHNSwHsmEImfptnQlDeAO8afdH2XROkGomQ6iwLxCJwdsTNnzJT
         Qzj+5FIbqM/pfmCUdGZzoJDtcaejhzDAKqw200qx8WpZwPCGI6sybLWf6QA2XZlWTtmX
         PfXFC9g0QjYYNqOa5eJNBcqz0naoXHb3f0fRPVlid9dG3OlzlZN15h4yR0dJpf+wHQtY
         b1SPhNZkm9eF+HE7k+GyfFjTjZRE4zuuABISWM23B9Nuc5sekC1W2SCen/JXXZNu81Vk
         Fu9g==
X-Forwarded-Encrypted: i=1; AJvYcCXmZ02qJJIo5rY0/XtrNs6oYJNQi4XxbEsJn62GcwDz4s3jyQZvVw69ubdkyYmqPJ9u8bMPlWSV7hQ8tAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcE9Gfki7S0Y4KMP4Z3d9/cHOQVNo+wDBJ0kNH7RmIePjNzVfz
	zJqUzbXozYDWSIsCTZsYsC9JSofEHHgZi+dwfsZDewZtQn73KWrCEwx5APs02dOGWW8=
X-Gm-Gg: ASbGncsub7jr9fi2d9H6/ibWH3V3l+/1ezGTnpjv+vSPXCKoNVKq5HnywXnNdkYW4TU
	cChO/9x6sTBRE6eGCgJE8Hg4tM2qzhXu1wDXks9Te1t+rQdA/cxf1SKsah4wmwj9rCBizF1KyH0
	H8ir8CxAW1HOKyNwZQL3xobUhC7g+SwpqyRCBlBOQoBGJsdH/Blxz3ZXnlFz2hItq6DnZkdc/cb
	LKmmAbEf/n1iZvhYeaMyJqPdHhEmbLHBNIHCaEHuONn+DMixS56n/aDC+XWvmaWINqUiLbRWY4L
	1Aofqk4Sj9cD83UoqSEOHp4GftwpD4QtG7LgdqwwBXXamjoR41D9sj7iqNF0cZW96nKE/x1LkiO
	S1InNxf9TUn5gkos9rL9s
X-Google-Smtp-Source: AGHT+IEUK5YxYWi+V5YGljb21gJhlrrSTSaF6hPULhP4e3D+hleSH74OxqsThIvkIQTiAsvoJfkRVQ==
X-Received: by 2002:a17:903:290b:b0:235:f45f:ed55 with SMTP id d9443c01a7336-23e2b44525emr13611865ad.1.1752679365284;
        Wed, 16 Jul 2025 08:22:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:b02a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de43227acsm129073585ad.124.2025.07.16.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:44 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:22:44 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Jul 2025 08:22:15 PDT (-0700)
Subject:     Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race condition
In-Reply-To: <20250709124536.4ce3a90b@batman.local.home>
CC: alexghiti@rivosinc.com, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>,
  linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  rabenda.cn@gmail.com, wangruikang@iscas.ac.cn, ziyao@disroot.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rostedt@goodmis.org
Message-ID: <mhng-E799444F-E3F5-4100-B236-45026970E1A5@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 09 Jul 2025 09:45:36 PDT (-0700), rostedt@goodmis.org wrote:
> On Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> >  #ifdef CONFIG_DYNAMIC_FTRACE
>> > +void ftrace_arch_code_modify_prepare(void)
>> > +{
>> > +	mutex_lock(&text_mutex);
>> > +}
>> > +
>> > +void ftrace_arch_code_modify_post_process(void)
>> > +{
>> > +	mutex_unlock(&text_mutex);
>> > +}
>>
>> IIRC there's a reason we don't do it this way, we had (or had tried to)
>> have it before.  It's been a while, though, and I'm just having some a
>> coffee so may I'm just wrong...
>
> Yes, because it caused issues with stop machine[1], but if you are no
> longer using stop machine, this should be what you should do now.
>
> [1] https://lore.kernel.org/all/20220310045454.672097-1-changbin.du@gmail.com/

Thanks.  The v2 staged for the tester, should show up on fixes soon.

>
> -- Steve

