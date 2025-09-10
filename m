Return-Path: <linux-kernel+bounces-809238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545CB50A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266291C6120C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD92144C9;
	Wed, 10 Sep 2025 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfP00S3x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C3218ACC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468419; cv=none; b=uhsgBkK4MYwAQpFEI9dwyWcenYPAGK4qA0eIr4xnJ7zrdd7nO6qz/SwvRRul1kpAcH15q/7REkBzLilEE1gTH9bYIJsxQRcDko+35tdy2rg32rsj+0HNlmxn5M43bm+mOW9nYUAG5B7nbibWp7HhSEfxZqMQc6CQgudMMvMaEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468419; c=relaxed/simple;
	bh=FHt07G2ckc/YJ1ZcIYot/VUnYBJdpLJpENBo+p+6XNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKrvvIZIDSOBiV/n//vC192zVXMPyg7TlYGxOL+UrSCGezgvDonuvveav2FM5O0ch+t+aBRorIb5+YtBh+4JddkLwIIakXQnia4BVP6FPF1XEYYZA/Ec1u1qBe2Se8lKupJgykdGmoBjGIENu6GgRul4zUdqvprr8roYbnmi0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfP00S3x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757468417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bf0TnMJBEYNTRXq3aALRg5uk33yVz0wdtITnMYWXzk=;
	b=TfP00S3xsJUlYhEa79PdUAnpEgLRqy3Wf20FQHuZXE0+IE92xsL5Jo4FF4FXannht8Kcbs
	AyD1cZq438OuM3z//VdUbyiGmeMgPcb8s09GWFmNIJAuvkk1LWExTTD5xnZyozVn1zPJ9Y
	MAeCG16fWSbC4QyicA8ANRokncP8XVc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-IzAhDUMgPq-7uDe851JRfg-1; Tue, 09 Sep 2025 21:40:15 -0400
X-MC-Unique: IzAhDUMgPq-7uDe851JRfg-1
X-Mimecast-MFC-AGG-ID: IzAhDUMgPq-7uDe851JRfg_1757468415
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329745d6960so6659804a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 18:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757468414; x=1758073214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bf0TnMJBEYNTRXq3aALRg5uk33yVz0wdtITnMYWXzk=;
        b=SMhLO+cpOp8V7g7YMD7ElS7/1GUXqwR5cj99Vs1y1P4rINpGXv/AoMP0rBxK+GeEZY
         RnbgUoTjg26sFIiMth7KmY/Ultm8nmBy8O2djb4H0Luwm0C8r6XD534gk9aiZVaW9v7o
         h0LPUYevlq8jqRbL5fH4mrc+/NWku6AFmclvvC3dzScvA2Ph4pECJLJnsKkrZoM2aAhk
         08nTY3XjAGAXFKsw6TXLYaQbmtBTefzaYSo9ST49rabLkUd/zGzxhpMGmFJCvNEm0cA3
         lp8Cqgy/2zpHh9afr7Z5GzOQzhb6cy6MF8q5Ea+7OkjGQn4UNOme8WP0+1Sovm7K1Jni
         ePYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Yr0LmWgwv3VfqrLpDaGNKhB2k0eHJNrg/64D1nXF6C8JWoitEeJ1DmbShZtvoY9Zv6+/4c0mYbF6i9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQnrq/plVEYhXzOJ68yb6UW9viKeA/TuQExlaUE3q0Io9VsmG
	xGgIZ+KD8+210Cf12kJ0femUqwG4IWP1dwti6ZwLZzGsSOteXos1qsqod0v1CWS7iPUmRQntDYD
	2oeYayI9nk5FN9+MTzXzkcg0Ci4PAEJOesyke7fzn9HSTW8QwfTGa2B3HcKHYq31wkg==
X-Gm-Gg: ASbGncsMayVEpZ3KOYqsuKcJ111lC5Vogiqh4vxx4w0P3aotAF81qJx5vn12BagUMiT
	UzAFxPOgalArgpWJueiWUQaLD/GTHwZq/hYRcLzuC0+IKeUVOlpXH2uuNTQTTqyCaM9mfQkqqAw
	d3K+bDQXPfEm/EjCZ+foiSoqud0zOhBAFuzAXbicOkbirOO8FUkOYy+nDjaf4ZT+QMA2vnk+mFi
	+8HkQvp4/D5cdkaj1+p//thb0M+GWrkpNdn1BLwq0Rm8q+/hQMY1CrEAd4a95eSTynS9AyQ1K6z
	TJfwbjUwhu83wQte558dMlZqMn3PhFo=
X-Received: by 2002:a17:90b:3d04:b0:32a:34d8:33cf with SMTP id 98e67ed59e1d1-32d43f77634mr16823430a91.31.1757468414491;
        Tue, 09 Sep 2025 18:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQlNFYMJg6XtDWuyZkLB1653jaInOG0K9bglwWI7QAmLbCiyDXHVpiFBScl37R1NTsEoaMQ==
X-Received: by 2002:a17:90b:3d04:b0:32a:34d8:33cf with SMTP id 98e67ed59e1d1-32d43f77634mr16823406a91.31.1757468414115;
        Tue, 09 Sep 2025 18:40:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb00f880sm537261a91.0.2025.09.09.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 18:40:13 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:36:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>

On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
>On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
>> Hi Coiby,
>>
>> On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
>> > >
>> > > Even without an IMA appraise policy, the security xattrs are written out to the
>> > > filesystem, but the IMA_DIGSIG flag is not cached.
>> >
>> > It seems I miss some context for the above sentence. If no IMA policy is
>> > configured, no ima_iint_cache will be created. If you mean non-appraisal
>> > policy, will not caching IMA_DIGSIG flag cause any problem?
>>
>> Sorry.  What I was trying to say is that your test program illustrates the
>> problem both with or without any of the boot command line options as you
>> suggested - "ima_appraise=fix evm=fix ima_policy=appraise_tcb".  Writing some
>> other security xattr is a generic problem, whether the file is in policy or not,
>> whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should install
>> the IMA signature regardless.
>
>My mistake.  An appraise policy indeed needs to be defined for the file
>signature to be replaced with a file hash.

Thanks for the clarification! rpm-plugin-ima does try to install IMA
signature as shown from the following strace output,

     # strace rpm --reinstall ip*.rpm
     openat(11, "lnstat;68aee3f4", O_WRONLY|O_CREAT|O_EXCL, 0200) = 12
     dup(12)                                 = 13
     write(13, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0'\0\0\0\0\0\0"..., 19256) = 19256
     close(13)                               = 0
     getuid()                                = 0
     fchown(12, 0, 0)                        = 0
     fchmod(12, 0755)                        = 0
     getuid()                                = 0
     utimensat(12, NULL, [{tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */, {tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */], 0) = 0
     fsetxattr(12, "security.ima", "\3\2\4\3232\4I\0f0d\0020O\231\341q\323Q\322\235\341\7\323\224\205\2104\24\241\331#"..., 111, 0) = 0
     fsetxattr(12, "security.selinux", "system_u:object_r:bin_t:s0", 27, 0) = 0
     close(12)                               = 0

But after rpm-plugin-selinux sets security.selinux, the IMA
signature get cleared and is replaced with IMA hash.

>
>>
>> SELinux doesn't usually re-write the security.selinux xattr, so the problem is
>> hard to reproduce after installing the rpm-plugin-ima with "dnf reinstall
>> <package>".

Since rpm-plugin-selinux will write security.selinux for a newly
installed file, so this issue can be easily reproduced. If you want to
reproduce this issue by yourself, here are the steps to reproduce this
issue on Fedora,
1. Turn off secure boot and boot the kernel with 
    "ima_appraise=fix evm=fix ima_policy=appraise_tcb"
2. dnf install rpm-plugin-ima -y
3. dnf reinstall iproute -y
4. Run "getfattr -m - -d -e hex /usr/sbin/ip" to check if /usr/sbin/ip has IMA signature set

And my attached C reproducer is to extract the essence of what
rpm-plugin-ima does so it can be a minimal reproducer and also to
illustrate what the problem is.

>>
>> thanks,
>>
>> Mimi
>>
>

-- 
Best regards,
Coiby


