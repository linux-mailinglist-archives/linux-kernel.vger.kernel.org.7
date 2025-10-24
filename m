Return-Path: <linux-kernel+bounces-869578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8517C08366
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED3D1C823F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59B30EF7C;
	Fri, 24 Oct 2025 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX54p3Nw"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9A5478D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342738; cv=none; b=cWY3Sp5G85gj6lW5jsZNxIrIcmR91njJqu8A1Akp/Tg3f13jaXN0JQXw/byiEC6eZxTIveKcotw+9YCpVwkfYJSW5wV7llmqCwQa2b8IF+6bj0999k1LdXe0WwA23CS+K4jrPYSw9+dWBQu2OUfw0f7MzISMhd1qNd58UmU8ClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342738; c=relaxed/simple;
	bh=3FUcCcJlUQX9N5j73IHlm3kEsLEzA/w9xUA1plBPmHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph3brvuWKx+jlweqOeUsMjnDV9IdyH2F+hLGPt/a3WPlVXjE41toQc2/28DpchJOU1TRCdcX6uNKk4Ae3nL1AJBA58FuW5nv39YLGAb34nRut1TFDvz7/BeywcAUzZVsCYxwrJZicHjsFqldWxf3wWBHpYCOUV8E540jBosJ2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX54p3Nw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a28226dd13so1597150b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761342736; x=1761947536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FUcCcJlUQX9N5j73IHlm3kEsLEzA/w9xUA1plBPmHM=;
        b=BX54p3NwUqp6yfg0sONNeOSOuERF8z/epPbOJsMDVnuNsLOlKIbGpFpN336IED3z2o
         ABvi8DGdRRcKzUdNk1z0+sTa2GnKRRs9zMwbNzn0lKai+DP67KWqu8mnz9crpYrT7qv9
         +Gol/NgQa4rar3Eib0cePZPR0guYmF2XGQLviYYUP+OVDWZlJfNEc8VmmVoiynmdSA0c
         JXWzCb0lbx+LSPnvk25KgjhQpZ9YgmmsFI5gi6qe48OhBCDn+exiH92JPdxV8ok9pLyi
         BwuMmQaYrJ8OLt95B7xW1SM3OOVrWQNjFWfXXTnOfjbPMham8hHqUIbZhORL/9b2Lh+D
         Xrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761342736; x=1761947536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FUcCcJlUQX9N5j73IHlm3kEsLEzA/w9xUA1plBPmHM=;
        b=g999EEm+1L2RuM+LkX5kcqvUT+uA2iIFeYCYf+YU0Fz2hllCB4bM3GwFSd79OSYs4Y
         2faKAXezq13wUfIDpDnElhLh6Vr/j+hILgu2356njd1nOCmZ5l+r+FA2W3xy+HL7280p
         zBRCAzYC11NB1MPPrA5EYDYdPs4tIKLeIOKwBzWMrnZjH1kRZh55ZOJY3Akpnz8yaXCS
         4WmafKj0llVomGaDlZTzAemGQqtGKPAbz+Bjjh2DJQ4920u2cvcHCtsVeVnxJ6lX2Cl0
         gxm5KARJHCXYbdfTRNxKrS1p9we9VXovDFa+8UU4hwC4qh+nJQeZyUC+2m95hX6i4C5z
         sZoA==
X-Forwarded-Encrypted: i=1; AJvYcCXhRPSoOOieoIXdaMtR9AU5zAmry2cn9wvrThlVaf1hPgymuSVVvhamwFUKfMAiCAp0GsMlumjeyMD9N2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYysieCD8IFQw7UnecA4Bb74Oi3BNW2W67tC3jPDArvq3GOo50
	+/e+TfEpDBHzTdSRhPPmCPGCz73sr0rpD4uIxt8HTZnpMiE8eLOgtAdd
X-Gm-Gg: ASbGncu+ofwihKBlNtQBIPT3syAmNWD1pD/R+HWHYEKBsObqH1HLIs3bpERSjRkcuuu
	EtM4k3bKIeLa7ggZpeU5K8dbOHvfSoFNB01ARGPyR6jVKQ59lhsoLPMIVJBUqJXf0P/TWUFUu4k
	97nr32GmcyerklPVYxT0JasKnelR/JfQBEWyQ+v73Zn5BLIj70+whQDp6Z+hKDUtCvE/eRqkigg
	MOYGNCh4g/cjBAl/PD6sQKt/GhufRhBHgs5NuJSbBdC0vtk1JLDBlgCkDrE/rEx0YFXFjJvwmn6
	jAzSsVVDqpbnVJSrI5mhvJ9/pALzQHr6CtXlHEj9PGbpmFavCudvQCxsBjwSJGmkGP5F3GLT2lF
	Y5Lv4lsYkkVYXCJQP6Jb2r2dVqp4fzvB5uYYjVcM5apyMywOuFarO49/9VF6GuEgnjSBU60SeYm
	Bj9FeiZt/21V7SVggLUuAa7PvwVSB96XH1kxcSiRcsndDv0iuRdC2OJck=
X-Google-Smtp-Source: AGHT+IG3Hti9nXwXuPqxU1C5U9jMd0lkmL/3K+zlGQ2zLi7DLtFKyeyBcAj1+fh+6WnqvT2HxVfD+A==
X-Received: by 2002:a05:6a20:244b:b0:2d6:9a15:137a with SMTP id adf61e73a8af0-334a864368dmr42090465637.53.1761342736424;
        Fri, 24 Oct 2025 14:52:16 -0700 (PDT)
Received: from ?IPV6:2804:14c:5fc8:8033:7222:c3bd:a7e0:56ee? ([2804:14c:5fc8:8033:7222:c3bd:a7e0:56ee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3db6f7sm112347a91.0.2025.10.24.14.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 14:52:16 -0700 (PDT)
Message-ID: <51c4dbeb-7df4-458c-bfd1-1744462f50a3@gmail.com>
Date: Fri, 24 Oct 2025 18:52:12 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 craftfever <craftfever@airmail.cc>
References: <20251023035841.41406-1-pedrodemargomes@gmail.com>
 <e0886fdf-d198-4130-bd9a-be276c59da37@redhat.com>
Content-Language: en-US
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
In-Reply-To: <e0886fdf-d198-4130-bd9a-be276c59da37@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/23/25 07:13, David Hildenbrand wrote:
> As a note, we have similar code that should probably be doing a range walk instead: unmerge_ksm_pages()->break_ksm().
>
> It can be triggered on a range through unmerge_ksm_pages(), which gets called from:
>
> * ksm_madvise() through madvise(MADV_UNMERGEABLE).  There are not a lot of users of that function.
>
> * __ksm_del_vma() through ksm_del_vmas(). Effectively called when disabling KSM for a process either through the sysctl or from s390x gmap code when enabling storage keys for a VM.
>
> In both cases, it's not ksmd that's blocked, it's just that the operation (trigger by the app) takes longer.
>
> So both are not as critical as this thing here, but likely we should take care of it at some point.
>
> Interestingly, I converted that from a walk_page_range_vma() to folio_walk_start() after converting it from follow_page() to walk_page_range_vma().
>
> But we never did a range walk, we just walked individual addresses, because that's what break_ksm() does.
>
> We could effectively revert e317a8d8b4f600fc7ec9725e26417030ee594f52 and adjust it to perform an actual range walk by passing a range to break_ksm(). 


Thanks for letting me know. I will send a patch fixing this issue.


