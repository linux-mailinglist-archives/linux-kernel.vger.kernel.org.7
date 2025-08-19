Return-Path: <linux-kernel+bounces-774866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482DB2B88A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EEE565C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B830F812;
	Tue, 19 Aug 2025 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIZIaQrM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF727A465
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755580712; cv=none; b=cJyqemDgBrOJXikraSsxsOSt/QGbeFOpG7/lTFwY6UXOmn6kFerxjdcWTO9qWDBOgn2kqvObVpNHvzUn15n1OW6BtoWjNu37abGghbvxlnHQgW9s5JuUwriq4q4wJ4AYYAki65a90Jf4NIKug5DYjRSE370TdmBjEnGu6G4pCIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755580712; c=relaxed/simple;
	bh=zdaBsgQUjZK5jZdjOTjQs2N2yClZHeBLvycKAPOGO88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDss36qgF2ezRN8M1aKB6aHI1mQgesajaY/Xb675DMqB3+b7DAC+G/CHXsr96hvburqUbUg+hdA0qL9y49HRNtNJlEOL2aW/iZ1GogZYYG3jwurzbwr+02Tb9TBqEtkGrD7dCTrDU/a8WuMy80ird10Iozv7tSge8yz4fEbiI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIZIaQrM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755580709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjX13QutZXnn1qKaednamt5UGEEWdjs4CWpwGUcPMo8=;
	b=eIZIaQrMaavJR9//oRxZTO4YcELBID1CcqXvxCb8WsS9i/6DQNp6fZWh9gq/5CUuuAFsYT
	YTEcIEfS8ETECUnWoSfYV12G8weqmGmlJwemKdNryF70qSqlB552CFmBNx72+cGFz24upQ
	AhCBqAtGIhV4EA60myWmGV7ZbCK97A8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-BDum6o7TPteZBLQV-nXlzg-1; Tue, 19 Aug 2025 01:18:27 -0400
X-MC-Unique: BDum6o7TPteZBLQV-nXlzg-1
X-Mimecast-MFC-AGG-ID: BDum6o7TPteZBLQV-nXlzg_1755580707
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3234811cab3so3323255a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755580706; x=1756185506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjX13QutZXnn1qKaednamt5UGEEWdjs4CWpwGUcPMo8=;
        b=UR93zy+CNpnEfC7QO7TOTt4vHMk6vWvLawkSNWWxThBDEWzlVAEoF7emHoEu2TRVt9
         IwjMg/qRKZC3K8nvRc0vnfw78Ke+CmWKg3gFhH2l9+NTRGGWDn6C/ZqDFY0VBYyZamPN
         zEtAx0a2RZ4blfuWUjnVN0Z4xsOs1+wpNmYUD0iMouKS1oilv3yR/7qeOR6YiUy/tuT+
         9AV3zTNbs1gZgcglTxbfwZx3MXTDGONFQywYr8qOheoSF1f0jH0NwDm2aeRZP3MUk57b
         HXREELIYX02/BHtcei4gyArKPyD+T+jqM+BsVIp5J7Hj4lJUpLjxa4RBEE9V5ldjGUbD
         ApOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYKJCmMtDMUFJ0jLRcBe3VQi8RiABqMqFHO25fB3aZ9I2Hfw2R3Tpl1QleyQREHok+DvsD+2P09EtPjMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jLk1Wg9yFeOOSjkXuQGKbuLMa5QAU2Pfjg5X7jwcuyjDKnay
	l0RaegXxMJbsXfdotVrmWCLT7EtoYjYrnUdapAbvvREiLkK5Gx59CKvRnmK4AP+yaGJ6O73dmAh
	WSAfoebzj7M7HrDvxVXiXOlSr+hZcvwtHiywwXsCyKNq6qWbptLdFmSarHlIhGPP3BQ==
X-Gm-Gg: ASbGncsZLpAdo1IQXnxRTJskfKQdSW/CKe1861iEROQCibSKb/6mAtAPLu8R953ODAV
	wKdGlJx837CQt2cnqNPeguKLb0FEh51HxIMFTYzZYYyTNzPXx77Lxfq9jytjrw0vhjID0iMqWKC
	u0ql60O2pnMG7qR/KVtzKitXoeuWbHx+0awW3WJe8klMswixAehs8wBDCtGUcjS8WgRWKOLMg5H
	uFvxe/peJO0FS1AfxRvNopZeaBjYKdNIWtb0ZxnJRq+KafG/X6WcQl1pXx3sHly2CA+hV/NCCdE
	+b2tiCNFVYAzsrDHSkbIGA48aJZvDDly+w==
X-Received: by 2002:a17:90b:52d0:b0:321:1df6:97d3 with SMTP id 98e67ed59e1d1-32476a48131mr1753866a91.4.1755580706520;
        Mon, 18 Aug 2025 22:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKQtlvFs2YJ0QWir1GcVeLXlcL3oZn+i/4CwJGWIsBulVTOobg5SCDLAg5vIPERbvvmwB86A==
X-Received: by 2002:a17:90b:52d0:b0:321:1df6:97d3 with SMTP id 98e67ed59e1d1-32476a48131mr1753837a91.4.1755580706064;
        Mon, 18 Aug 2025 22:18:26 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324d32e2b53sm367456a91.8.2025.08.18.22.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:18:25 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:18:20 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Benno Lossin <lossin@kernel.org>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	lee@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rust-next 2/2] rust: samples: miscdevice: add lseek
 samples
Message-ID: <aKQJHOKOFn8i_F9Y@zeus>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
 <20250818135846.133722-3-ryasuoka@redhat.com>
 <DC5W7UQHOJSG.310L4WJ0AKZFE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC5W7UQHOJSG.310L4WJ0AKZFE@kernel.org>

On Tue, Aug 19, 2025 at 12:05:41AM +0200, Benno Lossin wrote:
> On Mon Aug 18, 2025 at 3:58 PM CEST, Ryosuke Yasuoka wrote:
> > +    fn llseek(me: Pin<&RustMiscDevice>, file: &File, offset: i64, whence: i32) -> Result<isize> {
> > +        dev_info!(me.dev, "LLSEEK Rust Misc Device Sample\n");
> > +        let pos: i64;
> > +        let eof: i64;
> > +
> > +        // SAFETY:
> > +        // * The file is valid for the duration of this call.
> > +        // * f_inode must be valid while the file is valid.
> > +        unsafe {
> > +            pos = (*file.as_ptr()).f_pos;
> > +            eof = (*(*file.as_ptr()).f_inode).i_size;
> > +        }
> 
> Please include abstractions for writing & reading the file position
> instead of using `unsafe`.

OK. I believe I probably need to modify on the kernel:fs::file::File to
add abstraction for writing & reading. I'll re-consider and send them in
v2 patch.

Thank you very much for your comment.

> ---
> Cheers,
> Benno
> 
> > +
> > +        let new_pos = match whence {
> > +            SEEK_SET => offset,
> > +            SEEK_CUR => pos + offset,
> > +            SEEK_END => eof + offset,
> > +            _ => {
> > +                dev_err!(me.dev, "LLSEEK does not recognised: {}.\n", whence);
> > +                return Err(EINVAL);
> > +            }
> > +        };
> > +
> > +        if new_pos < 0 {
> > +            dev_err!(me.dev, "The file offset becomes negative: {}.\n", new_pos);
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // SAFETY: The file is valid for the duration of this call.
> > +        let ret: isize = unsafe {
> > +            (*file.as_ptr()).f_pos = new_pos;
> > +            new_pos as isize
> > +        };
> > +
> > +        Ok(ret)
> > +    }
> > +
> >      fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
> >          dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
> >  
> 


