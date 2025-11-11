Return-Path: <linux-kernel+bounces-896026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BADC4F834
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1456B188DBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920F2C0288;
	Tue, 11 Nov 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REdD8h/z"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB12BD5BB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887286; cv=none; b=qCrSJkYsAcgSHCgGPCBOA8NYTMIRi+HUfXagZFEI98FHgTMg3IBGjTcjvTBtaEK6LQ/YmYOcNqf078EHXavHvKUeMglVzh+fG6gyVlqCGgWSXDei6Nd4Hv4yyubcbxZRqHfalSZzTc3mxaSylVH8wnnTC7xBsfDdjhSMG+2IZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887286; c=relaxed/simple;
	bh=gNjTFrNkSvtB3DchgmaRfnaI4p/1hKhkmvofjmSh3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsGGdjqhxwh4n0CVsWkEzGiYFnghDLJgwHuq43MxdvzEuTdXCca7el2Jpj0OxavKPsXXt535ATVmMY+kVWhrG7URT2njesXTktSleg976QxEwrLaGc3SJU83pYxrYksCW2/oMgWW1Bsm1ESt5OmHxpq8cnW1ziNSaMzPmaoWi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REdD8h/z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so732528f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762887283; x=1763492083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdRUynOgPlBXPJo6ql5MWyX9Riir7hsBESxiC86Kk1c=;
        b=REdD8h/zY3mS4QHg3GBtBWydN/gY5Sy4U9WLLR2CwEtpm0tzbgcdmUFh+/TRyR0Dkr
         r5WKCaqMnCsI0O3XMeYRbTaMOou7012/KuacLz8RcTP8+nBKQsxNCNzVr3MQs0BL5R6A
         aAugd7P8i+EH+l4iOJ2pfFzus9zkXLf8zwUo9giDA/4Yn0LOvWO4bWy+tzx9hAJTYyef
         3wF6gZ7a9iWF9NvUO2v22YP8syRMzFdRx4QzsQbpO0Gwxg2TGI84GSVcHWeOMQM+roB8
         /Bj5dmh8vhYDpINq6SfQcSHZY3euyAsOVnyARLGSRtCiLXGisoqs9a3HiNhZGMBEQRXs
         KyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762887283; x=1763492083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdRUynOgPlBXPJo6ql5MWyX9Riir7hsBESxiC86Kk1c=;
        b=nA0MudM/3MV/0zWxgYikh0USKCGUQgH3uwsl2cEsSLk+A/yN92c+hLqii1D97fE8Hh
         7j2MhasaPgpOlORDZWHwhOVkQrFNAexlVit/fTyKcAigUXenTLmO9vbQERBZfuyy7B+1
         XsmZoXutsXHz9y0hdqTtkyadG+QAheIYWl1pel46TmI5Vo4HplD2Eegrh81GlR8uit5z
         nYJfqRPB6KEeAhymwaWal5vnklWStEW5LveelmYNXPJj/xZTxRt69hFl++fgzunACEbM
         snRP/Mc2bdit/R4KrEd+IosIMO3OVOoY4j4oK3ICZLVu/IUeajtpr7vILfB05sl46Fou
         a1tw==
X-Forwarded-Encrypted: i=1; AJvYcCU2YTwuCqaO2oWQyFHtGQnTI/TSRvDS/HCB5ES8zKR2LxnErTO9hDX/XL0V72Ao/AbA8J+DZwrHah+s2KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkv3WCOIHYh3UJ7W7X3+Q8PGqmI52K8kXkCwR6bT11wm+jc9PO
	fRVhlIIQwHJNNvylnG0/bnH/1tVmqxMzW6D1jrqsxtNv3cWejFxfCLap
X-Gm-Gg: ASbGncudyOAVP6W6KjTUD4hTforL/v14KIE6WpFLztxYhVcFkuV0f7uzxsVp/sjuIYZ
	MCH5Ec9wRkvNmwpj2r7JY6mNAX9THeY/Kd5kePrh54OxhM4WAMUlxz5i19i8dmZtqZUYqaD/Ogh
	2dX9VzG0gyqMmBXsiLqgnYSqmtWXe4nbqAePw4h04lueVQMDwtYPPdIX5Y+54aJmwQlbAQ3CveH
	d4zoCfxgxpvl2NYoyUYnrQIWWRpulMDX9JgVJQZah+ZShQTmWyau/O/JFZn2Bmt0Dm9XC9UsSn7
	f6TF2l+DlwGYv7pCjWlTDkpSI/UUJzM4XNmGntDkRsEMkgzE6y0XuPN5cApsJhmfRqNq7CYY8jG
	pkLqgp3YS6woT3c2CC8zZ0BtcJRI5qu3pHuMEQum3dq6zbZ/gSEOpBGX7XNgT9rz+0i9PFuBWxj
	6hBCcvhMfROQ==
X-Google-Smtp-Source: AGHT+IGd0fmmG6z7kuRrMZdV6g6rc2EMUpgF61dCExt4OzGkFObjrnlzVeQMOCeTSTsuKBksjsQQTg==
X-Received: by 2002:adf:a41b:0:b0:42b:47ef:1d59 with SMTP id ffacd0b85a97d-42b47ef221bmr2063764f8f.4.1762887282987;
        Tue, 11 Nov 2025 10:54:42 -0800 (PST)
Received: from osama ([197.46.148.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd51dfsm271008845e9.5.2025.11.11.10.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 10:54:42 -0800 (PST)
Date: Tue, 11 Nov 2025 20:54:39 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: add missing newline to sysreg init log
Message-ID: <aROGOivTetFI01S_@osama>
References: <20251110211051.814728-1-osama.abdelkader@gmail.com>
 <86346kvr00.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86346kvr00.wl-maz@kernel.org>

On Tue, Nov 11, 2025 at 09:49:03AM +0000, Marc Zyngier wrote:
> On Mon, 10 Nov 2025 21:10:51 +0000,
> Osama Abdelkader <osama.abdelkader@gmail.com> wrote:
> > 
> > missing newline so the  message is merged with follow-on logs
> > the change only affects console output formatting, no behavioral impact.
> > 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  arch/arm64/kvm/arm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index 870953b4a8a7..156cd1a6106e 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -2845,7 +2845,7 @@ static __init int kvm_arm_init(void)
> >  
> >  	err = kvm_sys_reg_table_init();
> >  	if (err) {
> > -		kvm_info("Error initializing system register tables");
> > +		kvm_info("Error initializing system register tables\n");
> >  		return err;
> >  	}
> >  
> 
> Given that everything in kvm_sys_reg_table_init() already screams
> badly when it fails, I don't see the point of an additional message,
> and I'd rather remove it.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks Marc. I just sent the patch to drop that message.

Thank you,
Osama

