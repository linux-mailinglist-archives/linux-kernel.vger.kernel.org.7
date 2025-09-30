Return-Path: <linux-kernel+bounces-836980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A11BAB04B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2863AD026
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BED22F76F;
	Tue, 30 Sep 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoEg1y7J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F1227BB9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199420; cv=none; b=t+oIpKJy8KyIFPVWW/RUSVq2FCJtf+qr/pbJbgTC+GWrRmViei6l5753Mo6KW0ypAdjJswQTDIgPCTIp/CUuRWrBO/enLV+5HCO/OUordwBmoX6rGuoxrT7GBJdF1RzBI9kuwsbsFQSG2lBo7jWFFtW9yS5iFC3CfoKRU4Q3GZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199420; c=relaxed/simple;
	bh=xa4HxoWAweoAHG2RDIv1C/FqhLYA4Cj/JKKFW+roYH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8faoeTacjxuopoZqIpPBAQDTouBMuTiNcdvqLTyDMmPoV+adNqy+tPnIPAmgB/viYn2z5JbAUx6Rag1RHyV5DzaCymhyH0wLrUA9/AYym3N4Cr2XoiJiznbXGADN0t0SaZ9C27U2UTt0qFL8Ggh6GuwcXHLV2qoifWMvzc7Qi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoEg1y7J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLw646FETcEhr6pt1hAR0jSB69SbvyhL2sUx3GkHbgM=;
	b=PoEg1y7JhOGLYGEujnHEI9q62GLsy9LYfg2cVYdNDUO15Zu2goBI/YcdvHSGJ0nbvQzt6V
	n8AqUUfttT/HqLlexOqjkj78WApOnhZUvqklykrfIemIFdfwadTX2pSWmsbgsPgOadxG1Q
	VaKZ9sWV0vAXNgI4d7qGUF9oRpd61pM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-B1os9Y7TMLC2WQEolcBF2g-1; Mon, 29 Sep 2025 22:30:15 -0400
X-MC-Unique: B1os9Y7TMLC2WQEolcBF2g-1
X-Mimecast-MFC-AGG-ID: B1os9Y7TMLC2WQEolcBF2g_1759199414
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so7249046b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199414; x=1759804214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLw646FETcEhr6pt1hAR0jSB69SbvyhL2sUx3GkHbgM=;
        b=Ucvhuqz/wf9Cr2VZoRtW2BFmP1JDzD2YQ7Jxn/KWRX9tT+djUxXV7c+wprIAgnPMI+
         w9DrL+FpjCXTrQND1lrWRUJAfW+wQrn/Aaf5uCFk9jeqTY53Z4tXbxh+4oZNg1qU30Qa
         9TwvpMYZOuNl4BY4YFmH3zqjWunTblWpLAHATmJfdPLZaQDULiF9rzZTwudS6TU1MDKh
         xA4SMjnO+XFJQIx42MOdDL2+P7/v20U/RjIT9e9dXXf+8MAwlCoBaHQ7GTzF0dkqOf5V
         /0jrU0XaR/KEKl4slKhjvGJFUhy6J+4mPQjRJ3wlbzwhr0J8CF7pCzUQfkFCKW5XC0bU
         nydw==
X-Forwarded-Encrypted: i=1; AJvYcCWf1YNTLFRpgsWc977tSVzvgCUEV7tl6H8uN0tfIGircr74BcuDvWATPMdSiumsfN075tIIfgnqvpRB1a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOgh+4qGo0n77qBkqMpckeMpjF68A0qVlsvnIALgher3mZPL5
	6CwSc2MH7NZLyFqaXsP7pQgtD/qwE1DovjQPpcz8PDzu/G1yUTZlfjEmht1XRunJkDV8+8oQucJ
	dE2rErlum0MDbA+SRAr7Xw/kVDrwQdPjMmUTIfizLrDQKhvJE1aA3BHUUUGmd+asBNg==
X-Gm-Gg: ASbGncst/Ie9AxMdN27jXHhBKs/3JLePVOBzIauI2qGqAFmGD7L91mbHt1EgR0TDnM5
	vzkc/VweztcEud8AWu2HJgGwfJMUrxKbvpWXUICJwsMMv0CQGZhqriE3ev582FW+rZuyQR/fYaT
	MCaciEZnrlunwphe0Tyu098cBMQnjtUU78dIg9Rg7ADMMF3KlJ1nd/kJI3U/ocSm9GjAqlTSNej
	uWIjg0i2qovrqKOhg6zsPw93b2ib9h4h5jFca9nwdNJpLq593Y1lJddU5X6QoZgjWhWzrSBEyxk
	VdBIHqrYhDbPeMeMvLjrmpe0WLxTKUbNQWC4
X-Received: by 2002:a05:6a20:1584:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-2ff3761c78dmr13587202637.45.1759199414099;
        Mon, 29 Sep 2025 19:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQssRzZqqsjVu0dx6Au1P6OK5GAqkRiG3z/+IoQtaaJCIp8LBBr6jRbu+lZb/DNxd1eRAd0w==
X-Received: by 2002:a05:6a20:1584:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-2ff3761c78dmr13587154637.45.1759199413748;
        Mon, 29 Sep 2025 19:30:13 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cac77sm12652266a12.17.2025.09.29.19.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:30:13 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:28:10 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a file
 with IMA signature
Message-ID: <vof5b2yqwagsfhrfdj33k34cv3sefr4ggvw57l3wodtjbtbsnb@vfx3vtn5acmp>
References: <20250909041954.1626914-1-coxu@redhat.com>
 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
 <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
 <40e9c7bd15d4ab8b71ac335b5d896ed39c61980c.camel@linux.ibm.com>
 <4l7l4duxfximhzixruim3lnij5mhnlqs5srzycc6j6c2bu5zda@ogoj3ade37fd>
 <e74e81465e168a7f43583d5783850cc5fe7ca1c5.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e74e81465e168a7f43583d5783850cc5fe7ca1c5.camel@linux.ibm.com>

On Wed, Sep 24, 2025 at 11:27:03PM -0400, Mimi Zohar wrote:
>On Wed, 2025-09-24 at 16:03 +0800, Coiby Xu wrote:
>> On Mon, Sep 15, 2025 at 05:05:42PM -0400, Mimi Zohar wrote:
>> > On Wed, 2025-09-10 at 09:20 +0800, Coiby Xu wrote:
>> > > On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
>> > > > On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
>> > > > > When both IMA and EVM fix modes are enabled, accessing a file with IMA
>> > > > > signature won't cause security.evm to be fixed. But this doesn't happen
>> > > > > to a file with correct IMA hash already set because accessing it will
>> > > > > cause setting security.ima again which triggers fixing security.evm
>> > > > > thanks to security_inode_post_setxattr->evm_update_evmxattr.
>> > > > >
>> > > > > Let's use the same mechanism to fix security.evm for a file with IMA
>> > > > > signature.
>> > > > >
>> [...]
>> > > > > ---
>> > > > >  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
>> > > > >  1 file changed, 21 insertions(+), 6 deletions(-)
>> > > > >
>> > > > > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> > > > > index f435eff4667f..18c3907c5e44 100644
>> > > > > --- a/security/integrity/ima/ima_appraise.c
>> > > > > +++ b/security/integrity/ima/ima_appraise.c
>> > > > > @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>> > > > >  		integrity_audit_msg(audit_msgno, inode, filename,
>> > > > >  				    op, cause, rc, 0);
>> > > > >  	} else if (status != INTEGRITY_PASS) {
>> > > > > -		/* Fix mode, but don't replace file signatures. */
>> > > > > -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
>> > > > > -		    (!xattr_value ||
>> > > > > -		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
>> > > > > -			if (!ima_fix_xattr(dentry, iint))
>> > > > > -				status = INTEGRITY_PASS;
>> > > > > +		/*
>> > > > > +		 * Fix mode, but don't replace file signatures.
>> > > > > +		 *
>> > > > > +		 * When EVM fix mode is also enabled, security.evm will be
>> > > > > +		 * fixed automatically when security.ima is set because of
>> > > > > +		 * security_inode_post_setxattr->evm_update_evmxattr.
>> > > > > +		 */
>> > > > > +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>> > > > > +			if (!xattr_value ||
>> > > > > +			    xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>> > > > > +				if (ima_fix_xattr(dentry, iint))
>> > > > > +					status = INTEGRITY_PASS;
>> > > > > +			} else if (xattr_value->type == EVM_IMA_XATTR_DIGSIG &&
>> > > > > +				   evm_revalidate_status(XATTR_NAME_IMA)) {
>> > > > > +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
>> > > > > +							   dentry,
>> > > > > +							   XATTR_NAME_IMA,
>> > > > > +							   xattr_value,
>> > > > > +							   xattr_len, 0))
>> > > > > +					status = INTEGRITY_PASS;
>> > > > > +			}
>> > > > >  		}
>> >
>> > Instead of re-writing the IMA signature without a clear explanation, define a
>> > new EVM function named evm_fix_hmac() and add a call here in IMA. Only in EVM
>> > fix mode would evm_fix_hmac() update the EVM hmac.
>> >
>> >        } else if (status != INTEGRITY_PASS) {
>> >                /*
>> >                 * IMA fix mode updates the IMA file hash, which triggers EVM
>> >                 * to update security.evm.  ....
>> >                 *
>> >                 * Similarly, trigger fixing EVM HMAC for IMA file signatures.
>> >                 */
>> >                if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
>> >                        if (!xattr_value ||
>> >                            xattr_value->type != EVM_IMA_XATTR_DIGSIG) {
>> >                                if (ima_fix_xattr(dentry, iint))
>> >                                        status = INTEGRITY_PASS;
>> >                        } else if (status == INTEGRITY_NOLABEL) {
>> >                                evm_fix_hmac(dentry, XATTR_NAME_IMA, ....);
>> >                        }
>> >                }
>>
>> Thanks for the advice! I wonder if we should use existing
>> evm_update_evmxattr instead of defining a new EVM function.
>>
>>      /*
>>       * Calculate the hmac and update security.evm xattr
>>       *
>>       * Expects to be called with i_mutex locked.
>>       */
>>      int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>>      			const char *xattr_value, size_t xattr_value_len)
>>      {
>>      }
>>
>>
>> I already tried evm_update_evmxattr and can confirm it works.  But later
>> I switched to __vfs_setxattr_noperm because I thought it's consistent
>> with current logic of adding security.evm when there is already correct
>> security.ima and it's a slightly smaller change.
>
>Calling evm_inode_updatexattr() is limited to EVM.  Only after verifying the
>existing EVM value is evm_inode_updatexattr() called. For example, in
>evm_inode_setxattr() the existing EVM value is verified and then updated in
>evm_inode_post_setxattr(), by calling evm_inode_updatexattr().
>
>In this case, the new function evm_fix_hmac() would call evm_update_evmxattr()
>only after verifying the EVM mode is set to fix.

Thanks for the clarification! I've sent v2 to add the new function
evm_fix_hmac.

-- 
Best regards,
Coiby


