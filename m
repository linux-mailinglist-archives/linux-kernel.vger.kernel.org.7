Return-Path: <linux-kernel+bounces-816141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E7B57012
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1717A9E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB8619DF4F;
	Mon, 15 Sep 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDZu4KSI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868D6FC5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916619; cv=none; b=NRz+egP6Q2/eTQczY5losytFuPHPpzCEL7Z2Y5GudVi6zBnIkGjTJg09Xc3lYXOGgKlGkmDqNovQNY20VW4MOHm6ojwatZoUw+OLKPS+5paOgsvksyL8Z9zndCCwUoZYIwpgz7FxC9EVYe298R8NyFdEI7g3gd00kqEOh9JV5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916619; c=relaxed/simple;
	bh=hn/AO5Wc5PezQglXXzvuXeX5O2ZUagUhwm5XzDzqzz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZco+ASLk5zSM7yXOrp9/++xRg6VAOtG5J7GQfyux74IYtUXaIkB1qX9Lvw2FPf1hI6gXtXwSlrVNhzgVvXYbIqwHwMTUkLm+1MKdOJf+F24brQXKrwdrf+11pkgE26HKLOoTCv0a9wWE8KbhSijMDijLouPIwT2ZDEnWMH39LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDZu4KSI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757916616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQLpe+khIHoCgKf3IFT4TfFBdedPAuIsgy8bFmFQ+Iw=;
	b=FDZu4KSIx+7DitYOI9CXovl22k2hxG+gzb6gt4ooS/bApvsd2T2aZ+/dwaa5msKLkx/jH2
	AWBxnpv50Io5lECuntl0y58RxHQKIZv3vx3/d817uZ+nTFtTJLgiSzxW6BxvI9g6Xc88Ev
	sq/F52sTG/i4DbqCzDydNihfLKwKhrk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-sJSeGXlvOAue-GRgKG1rdA-1; Mon, 15 Sep 2025 02:10:15 -0400
X-MC-Unique: sJSeGXlvOAue-GRgKG1rdA-1
X-Mimecast-MFC-AGG-ID: sJSeGXlvOAue-GRgKG1rdA_1757916615
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54d1ae6fb3so303983a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757916615; x=1758521415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQLpe+khIHoCgKf3IFT4TfFBdedPAuIsgy8bFmFQ+Iw=;
        b=fCh+xmGyvfuCSrF2KQP0kXaEWjnNFrgCHxNsGYQCqs7J/4whbAU8g3TVihOdpm16/F
         KagnH5v5pu2HBAY4d8oKOY3dEFymWaCpT2LPiwDsGuhfIpLvemVdDQMLDlMsHnPI5M1J
         ehU1kBx8QKPIxQbxqZze0Sqm5E0ViNdrpV2r4CwSjX/cA9vezOo06R9DzavqWc4wS+XY
         fhWfzQ3uxdL6dCGSBkIzBC48gxvp7vFFGWqaqByU+yWDdWvkkuVTUOND3OVvS7nQEu/U
         wNd1nej2wliNQAY2627C0X8DhBKeJYVvBB3K6GJUADhn+kd6W/PiCeAJ59hTT9b5gGNT
         gm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqtJZTi5ppOtumwNhNkzzferDd2MDjrGwqy2yuWoRK9dZmfAwG3dQUlEZjLWlcw3mZznP1h5SmdEkMRjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznwwYAKOpY14q1GvbK2sXGF/0bYRuzmaueNPccOl63SCiEmzoD
	J8QdORXYAq2oJVmJFFjQ7Jra3F8l21U1YTra40XpXYwU7mqTeKyQ/KquUXiG5piSZDl6jboGZIn
	WZjxUUHYFvjNguBCaWnedcOvIT+F0giNdhGcJdDT2owNkxIUnQdZLdfjn8qNiU10FqQ==
X-Gm-Gg: ASbGncsLVAZ1CqgS8ytAVTwVJ81QO6Q64U3sD3ELPhp0CoBQOBbHhVAX5YgNQ3FMS0I
	K2xZCWPCYBLb4Xp/IStqwmTTlUlfzJ8vjsBGCvVKhFu8FIYlA11GtjYrce35A1r7MHLO8f+C+iq
	FlMqlGqhk6u2Pn5WMC/RU31TcEEFEgaeMTgke0j/1PwixoxhuEP3J4kXCSidh4r7AxqwZ2Ak+tB
	9tkAawGnjzxj/UOupJy5MG7QHCqfod2SLWaMr44pABtKuFG3ictPJyKLDlEVX6uQ1LKmIuPy6nM
	udRRXe/5Cb0ITAhD8SjqpH/yg4wABAc=
X-Received: by 2002:a05:6a20:748d:b0:249:467e:ba57 with SMTP id adf61e73a8af0-2602a59a02amr14839226637.24.1757916614657;
        Sun, 14 Sep 2025 23:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECQRPiQitOqtajzh6bXpLG+V7zH9SLL0OR61z/8orLwVHwrBxRsiKGz8RZndsKYlzFa4Vdpw==
X-Received: by 2002:a05:6a20:748d:b0:249:467e:ba57 with SMTP id adf61e73a8af0-2602a59a02amr14839189637.24.1757916614030;
        Sun, 14 Sep 2025 23:10:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793bc77sm11823853b3a.4.2025.09.14.23.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:10:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:07:04 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <xy26wjlyha2m3jlcnowr74q4mv2vyr7xzm7zh2ab47osx5hffi@jhwihai3t4wb>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
 <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
 <6f2b7320b691669068dda110c29c25f8aae2f244.camel@linux.ibm.com>
 <gw7xopwfzrp5qatwqa4n4i3miztbvbdolfaa2jxslb5pktc7fs@56r7n6feu55m>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <gw7xopwfzrp5qatwqa4n4i3miztbvbdolfaa2jxslb5pktc7fs@56r7n6feu55m>

On Mon, Sep 15, 2025 at 12:06:14PM +0800, Coiby Xu wrote:
>On Wed, Sep 10, 2025 at 08:21:33AM -0400, Mimi Zohar wrote:
>>On Wed, 2025-09-10 at 09:36 +0800, Coiby Xu wrote:
>>>On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
>>>> On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
>>>> > Hi Coiby,
>>>> >
>>>> > On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
>>>> > > >
>>>> > > > Even without an IMA appraise policy, the security xattrs are written out to the
>>>> > > > filesystem, but the IMA_DIGSIG flag is not cached.
>>>> > >
>>>> > > It seems I miss some context for the above sentence. If no IMA policy is
>>>> > > configured, no ima_iint_cache will be created. If you mean non-appraisal
>>>> > > policy, will not caching IMA_DIGSIG flag cause any problem?
>>>> >
>>>> > Sorry.  What I was trying to say is that your test program illustrates the
>>>> > problem both with or without any of the boot command line options as you
>>>> > suggested - "ima_appraise=fix evm=fix ima_policy=appraise_tcb".  Writing some
>>>> > other security xattr is a generic problem, whether the file is in policy or not,
>>>> > whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should install
>>>> > the IMA signature regardless.
>>>>
>>>> My mistake.  An appraise policy indeed needs to be defined for the file
>>>> signature to be replaced with a file hash.
>>>
>>>Thanks for the clarification! rpm-plugin-ima does try to install IMA
>>>signature as shown from the following strace output,
>>
>>Agreed. I was referring to the SELinux label, which would be installed for new
>>files, but not necessarily re-installed on existing files.  The test program
>>simplified testing.  Thank you.
>
>My pleasure! Note reinstalling a package using dnf/rpm is equivalent to
>installing a new package in terms of this issue. Because according to
>the strace output and rpm's source code, when reinstalling a package,
>the following steps happens, taking lnstat as an example,
>
>1. A temporary file "lnstat;68aee3f4" is created
>2. Read the content from RPM and write it to lnstat;68aee3f4
>3. Set file permission
>4. Set security.ima by rpm-plugin-ima
>5. Set security.selinux by rpm-plugin-selinux
>6. Rename "lnstat;68aee3f4" to lnstat
>
>And here's the strace output,
>
>    # strace rpm --reinstall ip*.rpm
>    openat(11, "lnstat;68aee3f4", O_WRONLY|O_CREAT|O_EXCL, 0200) = 12
>    dup(12)                                 = 13
>    write(13, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0'\0\0\0\0\0\0"..., 19256) = 19256
>    close(13)                               = 0
>    getuid()                                = 0
>    fchown(12, 0, 0)                        = 0
>    fchmod(12, 0755)                        = 0
>    getuid()                                = 0
>    utimensat(12, NULL, [{tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */, {tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */], 0) = 0
>    fsetxattr(12, "security.ima", "\3\2\4\3232\4I\0f0d\0020O\231\341q\323Q\322\235\341\7\323\224\205\2104\24\241\331#"..., 111, 0) = 0
>    fsetxattr(12, "security.selinux", "system_u:object_r:bin_t:s0", 27, 0) = 0
>    close(12)                               = 0
>    ...
>    renameat(11, "lnstat;68aee3f4", 11, "lnstat") = 0

Btw, I realize my commit message that says the problem happens when reinstalling a
package can be a bit misleading. So in v3, I rephrase it as 
"... installing/reinstalling a package will not make good reference IMA generated"


