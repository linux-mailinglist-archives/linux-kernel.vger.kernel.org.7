Return-Path: <linux-kernel+bounces-758548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C094B1D0AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B47B306C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CC1A23B0;
	Thu,  7 Aug 2025 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4k4FZ1w"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5C8F6E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531262; cv=none; b=mF2745S7w+/l1NfFh/rtHoy5Z7dmhxyDWBJ1+lwZdAaVhD0zGWE+REdn5Met4CX4rGeYzTJcPngkS6UskPBcr78O5fcqZQQANkXNOorY1ZhBq0B7L5lBNQuTAfikY4+ZD8QA8Z+IHv1JDe/qJ5H4FOrLB1cRJvJvKNXM4ggmk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531262; c=relaxed/simple;
	bh=3/ZBMbX1rfnr2/RwjuPJssXYwyCyUeok6+T+rCEfBb8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EVsaCqtmq8PAFkH0rTpHdEDnfroWc4e13Ui2csbsIFQ/THRVPDdKXHjUf/m1696l3QRJe6AUPSY4BKG0FJDct2PfRlxtoC6MGWG7o166y+Uyl3s5P0e/Oi7FSwoS08qGA9udhu0QQ3RgAUIwda2hYPz3A/6GIuOZQ8Qj+eWMRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4k4FZ1w; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70749eac23dso5268576d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754531259; x=1755136059; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aY5+apIPDPz1zLZWet0eNNipx7u+zsC5VKHubvKB0qY=;
        b=B4k4FZ1wJZ26kcCyeGSrszGuKAKl02WCI416bWqISmNCYvQ6EK0AwLXxPrtiF/M/fm
         MF1URsmzdzSnjtufA6F0oLPbUx3DFAYc3mjPhq8qHsETHQtpzzA1uBK2jvfcuJAtWARt
         8psGtVUIPqJUEgVFmIQTLPiUStheypEhm4FdE8E+q4ECs5mrE2GFlspXgM/2UyotyEkw
         3h1N5F9N/dg0Plh2auIG28/P1Ux8s+lusU0xAMhRO/YymAXtDmme7kQ++SvAPv6xlKpb
         IUdfapwquOomZ90aZB38VYLfQ1S0aF+VAb/G72wwKKH5UtsJ84+lL+ziZhM77AY8qq3a
         Vrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531259; x=1755136059;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aY5+apIPDPz1zLZWet0eNNipx7u+zsC5VKHubvKB0qY=;
        b=H2mAstqe/on9F3nlp8GeQCNa/Y+dTRPH2bzNijyiRj6bXWLKJCmC8hHwcoCTf2ESjb
         lfqbXDxwjXndfxub+kJG/havpVfhI9ENMn/36i3mkzJ6K7exUP1kivPJiyWq/IDY/YOJ
         elArG3dEj3eH6LnFjnHZ1NCbvfRadVSBt3boaPYtmd0bh4kdMNUOnaXHGISQgIM7c9cW
         jqj/D3XCB6IAxaAAjgFmpMmCF0R0xGysSWiAQjSjJXaTp8749ssvJsEkciYJqx/eAQe4
         /HIcdzQniTBvMIS9xBMcy67de4ER7t+V6oGis20Akes8Y8N2QXvgcavK+QCgQu6KStRh
         I4/w==
X-Forwarded-Encrypted: i=1; AJvYcCUq0QR30otWY/6CXuSHAvR0jqySdATUG/OHbC7MsCHowrKPSaoKCWRvmKbTPMAdLS8W/4bAjFlEngEPUgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmsGCMmCsEeS7Fl6VVZdJDG80gQWNeGDHjxQ8gvdJEVh6sHFY
	9K21TGZP68yoc35pKJaQFZVN1vToqkgzEKgwZdXAs6wUQ8voALzGczQlXYV5YeGnYg==
X-Gm-Gg: ASbGncsRHwQmundTOU8y9BHxFHjv/zWzQtIBun3aPU6qvTqavKazLb35Ed6dFvhyiIf
	S0oexilNwTnl5ozKWNM/kFefPdUjWveTlKd+tbRVWy9dXt+Y0FInmVClTcXCKhH7FHmBGp4Y3g9
	VGzpKhEqR4LmQTx6omnqVfBggN9LfnmG5NTyb3m2ySysI4+f6B7/r10en7ycpDEgzHRYhjboJZm
	jDLRSd19KxUFcqBTICmbL0PyaPJhe1vw7ZhOTUp7a/VQ9LHYYEKMm9rxMnYITCYIBhJ2PEcp2pm
	3hmv5E3jHGPvbFXlZg6Q0b01GQXo/2N5kdPP6eB6uRl+7HzrvRYy7ssZHYgUB9L/wTAZ6zTGJ3S
	IRs05gsnyJDwlZ5TwIJ9veNGrHGF9vnENEf9Bd45Q9OQm/AXf+ORdQNtgOchnEIun1hf5D6s2iB
	OrHg==
X-Google-Smtp-Source: AGHT+IG8gljUkhxjIhCTlEyvnsU1ykkoPiUWoXdbBKK7biBWjQdmiSFWNhS7Sn1nsxWyxlD0vdtbTg==
X-Received: by 2002:a05:6214:20cf:b0:707:76a8:ee9d with SMTP id 6a1803df08f44-7097b055482mr61183906d6.51.1754531259574;
        Wed, 06 Aug 2025 18:47:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077cd69b86sm93679226d6.42.2025.08.06.18.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:47:38 -0700 (PDT)
Date: Wed, 06 Aug 2025 21:47:38 -0400
Message-ID: <74767dff9834360b2100907df5142ab9@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250806_1659/pstg-lib:20250806_1657/pstg-pwork:20250806_1659
From: Paul Moore <paul@paul-moore.com>
To: Richard Guy Briggs <rgb@redhat.com>, Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] audit: record fanotify event regardless of presence of  rules
References: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
In-Reply-To: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>

On Aug  6, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> When no audit rules are in place, fanotify event results are
> unconditionally dropped due to an explicit check for the existence of
> any audit rules.  Given this is a report from another security
> sub-system, allow it to be recorded regardless of the existence of any
> audit rules.
> 
> To test, install and run the fapolicyd daemon with default config.  Then
> as an unprivileged user, create and run a very simple binary that should
> be denied.  Then check for an event with
> 	ausearch -m FANOTIFY -ts recent
> 
> Link: https://issues.redhat.com/browse/RHEL-9065
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> changelog:
> v2
> - re-add audit_enabled check
> ---
>  include/linux/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/dev-staging with the plan being to merge it to
audit/dev once the merge window closes.

--
paul-moore.com

