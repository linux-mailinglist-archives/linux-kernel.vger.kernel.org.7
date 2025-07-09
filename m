Return-Path: <linux-kernel+bounces-722808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8EAFDF3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300463B4F94
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A126A1A8;
	Wed,  9 Jul 2025 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lanB2ZwQ"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053418A6AE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038916; cv=none; b=amtr6UWNVDlu/RMYyU7ocFmzuJny52tWoMruTbAQj3T3upetYhq//lcaHv4ivnQnUOUasvFr5XzzNJojQvorLuZshqAXV7zAkP8f2RTIZNO7hvURvUkrhIX5TC3N421U7OpeUydOS9McklH/DHzl+EBOn5ZS9T4pX8g6/jsr/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038916; c=relaxed/simple;
	bh=qQhBbkuRCb5abHb5/wuunk50USfP1AtiGuyVPyIbw3w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YegLTuvPRRJ5c3Y6of6a64T1qgN7QezPIy77h6fgjzI59X4eCASEPLymCcEHpFcgmAs01e23ePk+bCdtMHc780wWWAKreig+HVzwpHvhcvp3h/EBjywstAY361c8wp8R3OOb4Vc7Q9UEOb33bU7Y7M5M66Spj8vnJ/F+KdCeHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lanB2ZwQ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso50816926d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752038913; x=1752643713; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmTUuBucPnJJtTwohcG1cSiuqeCooajCyx13/5KvFME=;
        b=lanB2ZwQRb7VECtzW8iQ8gU411xcgOyh5uritjthQ51zlpKGWozUzZuqEuU9biaGeI
         7r3pNloDMnCgJ/4E3LSCXgQiCa8NZfxhYe0jtFNqA2ZGBfd1v/GFro4/dRMZr95aqwCy
         4JRNQaP7EEpZYjhVGPgCYfIR9zrf/NHWH5qDURVwtF3z89j51jxS3KckOTCpsQFPhasu
         Z/TUrgim0tX+P2ekX+bfveJLRhTral37DL44TA+RkFkQSQKFaBoatoRVJC3QrD+i/GeQ
         k01BWz4h4jxCHzhkKoLjtvrWkXzCnrVAl47cNvb8SkIEpVOgFxLvS8vVEiVWhVbRyrUX
         HQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752038913; x=1752643713;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmTUuBucPnJJtTwohcG1cSiuqeCooajCyx13/5KvFME=;
        b=dF4z1ZQaZcoxxCxBKt+6cNzLJqyFZ/f7a+6gFX1HNjPcABaf0zFwhD+wJCqeswxqzL
         4T33JAVJNE1Y4JVIFaLU+j7GtWkfNfP6jdCJvrVhUtIizTtGggB4jYCjjjqW08ZgWH1C
         tDaM8IsSu7UfbkicnezFsuyBuIil/eOL6oS/eQi7IgcwVaxsztLuzx+O13/+m4egS6bS
         co/CmnlAAx+hsGtqPOweAWoT0RCkVjtGdlsmzDz4DYxgyyxNjFigMY9ftlCOtMSXBBw0
         sw93tbwKuJWsXQhmVX3Q6zMtx3X5cHoSVUGG4giD4G0ufFoqVA6LR8B2IxmTr6KFHvdD
         4/wA==
X-Forwarded-Encrypted: i=1; AJvYcCVIz9qKOJPl/nZfffL5HNiSvbBDW2eSLl9F+6RExLtQQ7Z3eFhZy29bk4UCOChaOOrqEA8cVS3+6enLiw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+YCOdFaz4gKs9JWjSMXwvTm5/gTt8MYKLAktKIn/gE1CQpIF
	AkbjCaeGf//RF495m9eBGYrSVx9LMnHqo6oXYHuIBOdShNGZQJCGXgnH
X-Gm-Gg: ASbGncvsVv7cUIYBeSqkQJiXPqus5UaEG2J/lu/xQoZV0yfUyWizCnukNhYsR1I4FAL
	S3mr/08RrcTIuSm7U1wutwBJWfqmFk03RuxgjYadA7kSymtAiVPIZwkgH+KCKEs73w9MgyhHrmr
	viOs/3aiRH4UR5S4+B0u5gVFvVZ2pBKO2gtFovzInBpQrugWvW47ClcmpoqVoM25RvdzMljNSdR
	sj/xxnD4EyMG/OQmQrPpQ8F46opYJZItl1MKdR8bDoObgCbCmHx56wV15InKas218dzqxNjA5oY
	ua/d+172LPyd+tRlTYiAAwhDJWI66RDtQ6+iku7yZhCWpoqt38uwyCAEkeWcz5TzV1+c28IBuuR
	6haY=
X-Google-Smtp-Source: AGHT+IGb4zyDMgc3aL8iisihI2BiI+6TLsoLVISX2Ir5g30xcL9nrjPG9mF0sxeGZCC9YuroHjICyQ==
X-Received: by 2002:a05:6214:3107:b0:700:bce1:495a with SMTP id 6a1803df08f44-7048b8bd8cemr18045456d6.1.1752038912844;
        Tue, 08 Jul 2025 22:28:32 -0700 (PDT)
Received: from smtpclient.apple ([38.45.64.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50e14sm86453156d6.74.2025.07.08.22.28.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jul 2025 22:28:32 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] riscv: mmap(): use unsigned offset type in riscv_sys_mmap
From: "Han Gao (Revy)" <rabenda.cn@gmail.com>
In-Reply-To: <20250707193411886Kc-TWknP0PER2_sEg-byb@zte.com.cn>
Date: Wed, 9 Jul 2025 13:28:18 +0800
Cc: paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 alex@ghiti.fr,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EDA763D9-2FA6-4F0F-9855-01D59E340A52@gmail.com>
References: <20250707193411886Kc-TWknP0PER2_sEg-byb@zte.com.cn>
To: liu.xuemei1@zte.com.cn
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On Jul 7, 2025, at 19:34, liu.xuemei1@zte.com.cn wrote:
> 
> From: Jessica Liu <liu.xuemei1@zte.com.cn>
> 
> The variable type of offset should be consistent with the relevant
> interfaces of mmap which described in commit 295f10061af0 ("syscalls:
> mmap(): use unsigned offset type consistently). Otherwise, a user input
> with the top bit set would result in a negative page offset rather than a
> large one.
> 
> Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
Tested-by: Han Gao <rabenda.cn@gmail.com>
> ---
> arch/riscv/kernel/sys_riscv.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index d77afe05578f..795b2e815ac9 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -10,7 +10,7 @@
> 
> static long riscv_sys_mmap(unsigned long addr, unsigned long len,
> 			   unsigned long prot, unsigned long flags,
> -			   unsigned long fd, off_t offset,
> +			   unsigned long fd, unsigned long offset,
> 			   unsigned long page_shift_offset)
> {
> 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
> -- 
> 2.25.1
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


