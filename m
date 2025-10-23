Return-Path: <linux-kernel+bounces-867585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D6C0309A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 517204E1EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F46280035;
	Thu, 23 Oct 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JP14phuU"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223126F2AC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244880; cv=none; b=Jp5lGyw91oGVSLBaFJQHbssBAh+ZCkuGrUPStFsBdEgFd/GK2q//SHoCcS9qDkqMohLWu30MofbT0gEadm4Wlppac3YB4JQh6OD82e4h4YyxuWb9mAIfCmvT9JY72K2JEMhygHm9Y2jsp0lr763JYHUt8/ZNAsTaezZSPNxMrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244880; c=relaxed/simple;
	bh=IB4y5AHNYRtdR201nNfBi/IkRYsNB8voCIGCo03zGns=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=D/CGT4lcRs+YfBOm0IZOQepc4nVf63CEavNmRXRfUZeOEsubJ79GXXFR2+mOzIiB0BB5/hj2ydpEWKfPkmHxftXJruxecGmqS/LG7zKAASefDEsa/EHIFFSH48r4wVnhma+6IG7G663SJyuju0idC5/ZV06f65TNAX/upKPKY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JP14phuU; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88f79ae58f0so129405585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761244877; x=1761849677; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tmaPCByA6miqx0CEbKAWxagIl28CyBryGaexUihdIk=;
        b=JP14phuUJMQ4hGdpp4n0stnQ5tTuq1dJ88+Jl470jr8mVCM72gnhuUXm6en1SynR8A
         ZzAQnG2dG3obJmQwScQtAtRn9RYgRMrCRqpYZ8le9OxoVRIMKpOr1DS62drWu6/zDxTW
         qb8hBdCYfFYgens3U8a16Ie0ib9jfjiLBuQkGyvUjVpLt2VckTmFk+bB6bAj+npG2xUN
         sAN/EBBiFY1gbcwC4e7lzgzbv2C+A4A+58DC1aQWg4i2yZeozS39mCDaxjryCFntv9rt
         ww0Kz28WrGhedEreYtmF7H5QBel0XpAj5EhBubJsF2IjI8qRwmVnGNA70s7GoYt4eHFw
         U4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244877; x=1761849677;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tmaPCByA6miqx0CEbKAWxagIl28CyBryGaexUihdIk=;
        b=qPV9hOFitG5XWglzJKzXFuC131MFly6xs2LLHFg9MS4XVnxN9aBrjITaBu0NKkYcuR
         jYow0yleITPrrFPV29HQZSP/9ZqYumNd9qJW/Q1femanzst3Pis25hPm0Iw3FKURjiVO
         QQa/xuFNbW82QecNiyxBtCjtETt/dhiI/ohCO43QCgMvMfShc8WDA3U15b7wCAwO2gJy
         1/VYZa83NlLbfrXcC42g5BeswYvAYWb1A7YdyfznrPuLRpxvwUigRpvPAyIQvsan1uxt
         mcixJDvu1Dl5Xm+n9efBmKkmT/v87H5FUTEDaiF/ZoDV512Q26eNAO1wh2DDHc5bTpHt
         7XNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHvlpJaBlBA/OIEpyIS/ELrDyYhj4S2Q+M4lQpYaUGosc6HhMzu/rdOXCL/QCI12iHxV07sr85PXXHams=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFE0SYjhC06X896Vna3Gs9jC3+3a4ISHdn4Fx0oWYYITYMWFlF
	L2rHpsDxiubgnDerOL8ncgiGm6wPiBAZhHzCCkAYRxOTKpp85eTd+PtUCSs4KNJNQw==
X-Gm-Gg: ASbGncsIKq1vsK9odmESYOq02pj+/YfarP25bCYCrTsBIWMdqcf/nEnLT4N+qoGpx+V
	9dCUXNhoxhMSUf9k5WOUL9s2LBbwtOdeyc0M96nnpSWFcfo6e4DCfwoOIR2SnuJF1nn9O10Do0q
	xPJj4M3QcjLqPKHuPUz8tAGx9DPoQC9bISKKAWWvOFoLGzhdDbQwb3UXIl0IRQjAcB+T7Hjidht
	f1VhRCQwTDSXR107dLjrVRZia5Zzo8VLBNBeIOaztz1OuGOLf6/scHichMD2C6xVJZ56mcQoRbj
	kM8Qy14h0d3nQJugd83pTuc1e0uQhhvCdo2eE+OcrxHxwOLb+VWX69htbXsodi8ThuMo5SjOIN6
	76Vx9CgfglSN0aXHil/nBy1p6pFPNA1Msi2azALdcH7CiAtlV/6aalC699FMWHcEOAcUKMEu1O6
	5RVpCQod1gutqXHeJnzrKHpGaRq0gjQ0lJ6lPNI+0LD8siy3MPyLANh+TE
X-Google-Smtp-Source: AGHT+IGZGIJd5kSR4u1priNBK708NaQacpDTp6H7OVf6iWV3fUrpgDJKeJJaqGKCTMOXVL/lQFnYiQ==
X-Received: by 2002:a05:620a:4481:b0:89a:ad1c:5157 with SMTP id af79cd13be357-89aad1c55b2mr864530885a.0.1761244877347;
        Thu, 23 Oct 2025 11:41:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11e62e3esm212229885a.42.2025.10.23.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:41:16 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:41:15 -0400
Message-ID: <cd4576d9d4a00366283a116ab14231f5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251022_1923/pstg-lib:20251022_1701/pstg-pwork:20251022_1923
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v2] audit: merge loops in __audit_inode_child()
References: <20251022123644.1560744-1-rrobaina@redhat.com>
In-Reply-To: <20251022123644.1560744-1-rrobaina@redhat.com>

On Oct 22, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
> 
>    # uname -r
>    6.17.0-rc3+
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m42.753s
>    user 0m0.000s
>    sys  0m42.494s
> 
>    # perf record -a insmod loop max_loop=1000
>    # perf report --stdio |grep __audit_inode_child
>    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
> 
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
> 
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 54% performance enhancement for the benchmark.
> 
>    # uname -r
>    6.17.0-rc3+-enhanced
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m19.388s
>    user 0m0.000s
>    sys  0m19.149s
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1966144bdfe..8cebc016d9eb 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2416,41 +2416,36 @@ void __audit_inode_child(struct inode *parent,
>  	if (inode)
>  		handle_one(inode);
>  
> -	/* look for a parent entry first */
>  	list_for_each_entry(n, &context->names_list, list) {
> -		if (!n->name ||
> -		    (n->type != AUDIT_TYPE_PARENT &&
> -		     n->type != AUDIT_TYPE_UNKNOWN))
> +		/* can only match entries that have a name */
> +		if (!n->name)
>  			continue;
>  
> -		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> -		    !audit_compare_dname_path(dname,
> -					      n->name->name, n->name_len)) {
> +		/* look for a parent entry first */
> +		if (!found_parent &&
> +		    (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> +		     !audit_compare_dname_path(dname, n->name->name, n->name_len))) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = AUDIT_TYPE_PARENT;

As mentioned in my feedback on your v1 patch, we can probably set
n->type equal to AUDIT_TYPE_PARENT without checking n->type first
as it we want this set to AUDIT_TYPE_PARENT regardless.

Please either fix this, or explain why it needs to be the way that it
is in your v2 patch.

>  			found_parent = n;
> -			break;
> -		}
> -	}
> -
> -	cond_resched();
> -
> -	/* is there a matching child entry? */
> -	list_for_each_entry(n, &context->names_list, list) {
> -		/* can only match entries that have a name */
> -		if (!n->name ||
> -		    (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
> +			if (found_child)
> +				break;
>  			continue;
> +		}
>  
> -		if (!strcmp(dname->name, n->name->name) ||
> -		    !audit_compare_dname_path(dname, n->name->name,
> +		/* is there a matching child entry? */
> +		if (!found_child &&
> +		    (n->type == type || n->type == AUDIT_TYPE_UNKNOWN) &&
> +		    (!strcmp(dname->name, n->name->name) ||
> +		     !audit_compare_dname_path(dname, n->name->name,
>  						found_parent ?
>  						found_parent->name_len :
> -						AUDIT_NAME_FULL)) {
> +						AUDIT_NAME_FULL))) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = type;
>  			found_child = n;
> -			break;
> +			if (found_parent)
> +				break;
>  		}
>  	}
>  
> -- 
> 2.51.0

--
paul-moore.com

