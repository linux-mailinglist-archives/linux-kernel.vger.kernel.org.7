Return-Path: <linux-kernel+bounces-888633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E81C3B754
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D1BE4FD680
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ECE33B964;
	Thu,  6 Nov 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCdSZuin";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tUVQ5P4F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10533A01A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436419; cv=none; b=fv6c1raeHDyCiLYHQwFbGdrrGhpt5aBjtjQTbxzp6pj3C4APxCq5f5gIkxaIfVJ8TRX0uS7PqgAb8ilvwjlcC/h5rxbPm3PdWuHMuQfvPkFcos4EwHt7Gd+9bzwQivpIf6heFQrQm1D/dlCz6lj4uSc4dacjI8wy0BL0y5YM1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436419; c=relaxed/simple;
	bh=uUlzz1SanQRYx/DFcY6UUxeg99XLdI7AB5xH58h796U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyV2ap0/ytSpjl8c9X9fAZukQiRnVo++D8bS6P7IUyEoSv3ok5nMZhKsQkxmSmbI7mQ0viKn28lFglPZ8kS87CwRBQstTRrHo9gmbEROPUoNlcsr3vdyeZxdzDGzqSRgrI68PhK/nd+7o1LwU1Nhh9OZo0UOmhe9Bo2g9hfdyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCdSZuin; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tUVQ5P4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762436416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkz72yTbvJHMytWdiLGhiha3HbVo2IXnZtXQ3EROj+0=;
	b=FCdSZuinAnLW1iHv28D8qs1FbQ/hfhp0oW1hsi3ddViSo6E0R0rng+EM4O/Oc3rVuW7yNL
	wjhiCJicKSS6HOo+Tu8iT2TxsHJhxgeDv84rgIGHE45YxQZQNShxZkRrDpncyf9Skk4C5V
	RYhOFZs64QA2B1iiDaC2k808Xtr+BOA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-6fMa-WHbPgeuqyG3jQDUZg-1; Thu, 06 Nov 2025 08:40:15 -0500
X-MC-Unique: 6fMa-WHbPgeuqyG3jQDUZg-1
X-Mimecast-MFC-AGG-ID: 6fMa-WHbPgeuqyG3jQDUZg_1762436413
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b63038a6350so1652200a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762436413; x=1763041213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qkz72yTbvJHMytWdiLGhiha3HbVo2IXnZtXQ3EROj+0=;
        b=tUVQ5P4Ff5WuxoLkV60mfrV/tMsAsGbkd0sCpEGj7EuP0nO99fSQthh04oiODOaNHO
         hQvSaR962bxEHU6obdCPahESy8wz2pndtrh3yoHcL3DySfxx560GOoxF3BREJjfVpELR
         Zj2PJNDWa5RmaLEPrSjGpAlbCY4E1GE/0CxUZ9Z74iY8rf9rXtmN0PMqGImyOJqZ7x/I
         WEyBpOkYizn0DXc5uaXyMb/rAtJNxWbfF9qFGBBjNEj7p64ZEf4NKcaXujwLXCuozvAB
         8KysqlDvrDz4LOdKkieycI46egnMO0BSXdVLmm4ccdW7vELwYCzylRfT3PNEfgr2q5tM
         jUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436413; x=1763041213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkz72yTbvJHMytWdiLGhiha3HbVo2IXnZtXQ3EROj+0=;
        b=hCLEk3rWd6QACJq/1BOb112TN6rhm1JMcudlTOXRMc3T1jArCLGXwQB1xcODdfDbWj
         SP0Rnkswpu4nzQsM3kgPc/zpHMKHI5srg6/4Qwt8tz6q4SUiQWGAR01vf/rMncP9hEwd
         YCzd9CAleMzVoE7vKvyIs3srLjOOCbkTHjy/fkBf1cbPjgYHe/bVgJia2HRCRIxm2aMn
         cCM7kbRGZfrTaZ5HzwqEjiGpZFTXvWih5oJ/nTQynJ0TQDCpWVOy2o7tg3kEr4wneBrR
         b6jlJ9Qen/uQKwdbt08oOUIF3OYOi6s5Pu/rnulRSn4mjIKUTnm6O+Ah9sDsmsrFLm2C
         AIPA==
X-Forwarded-Encrypted: i=1; AJvYcCXJDMz5iAq4RP+HUU/M5C8k99+oAB7nC2g7BFrJTpgB1t+qcm9ubx1Fn7w/8J04vrMX7kamto898M54CH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3l0fFMn1lHU2PdzJrsUT6CaJq8s5MO/HxwUu9+ojp2qoy9Zaw
	pFfGqWkjMN4Yv9xRguXTAcwCT5RQ5e4T+Y6pR6YnS+W1wcJ8UUAkxouirOapHNNdOf+CrKeAa5T
	53IcB9rEZN1kutG+0SHLJaiMHXDGLGe92ka6B9T2ZhswarQvaer9wUrtpkTae/85LBg==
X-Gm-Gg: ASbGnctk6jwoPcGKWLE5iV5CCX8yyqt2FQwQcvPmJ0t/sHweLN9E0QWVkfwwvhSpkuI
	X2SnXUIxxLysBwLqqz73O01K6Dj/2iM77cSL3j1trSmSsjJh/eIbtcqD6dx2/n01vxqA8mUFuLu
	iwJh8bZfCMOmFzGJhCsKJzo/yR2OlLtM8qwz2cqFORmS+dS/rPGbn/TOF3hDEsJ+oh8gc+p6exF
	HxzGe1TO3ikryCzlmu9V1ukd2iRXzOGu1LSgm86IpIYvUoaOsBITjjNzmZHLq+ePgBbg9t2xv/o
	JAxGKT8k/LAdUMbKRf8m7igxmUbleaVm3NtC65C7Ao5tKKSzjtmW6t1TJAP5nCQkuw==
X-Received: by 2002:a05:6a21:998f:b0:33d:7c17:deb4 with SMTP id adf61e73a8af0-350de60ef4dmr4511313637.18.1762436412846;
        Thu, 06 Nov 2025 05:40:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpqJ2Tqnwq4JekdzegbtzxvbqJx+H0dECy9gVADvuDqgqPrgvVh+iyG7BrVNpmORyKNnpgRQ==
X-Received: by 2002:a05:6a21:998f:b0:33d:7c17:deb4 with SMTP id adf61e73a8af0-350de60ef4dmr4511262637.18.1762436412235;
        Thu, 06 Nov 2025 05:40:12 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f7565bbsm2913270b3a.9.2025.11.06.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:40:11 -0800 (PST)
Date: Thu, 6 Nov 2025 21:35:08 +0800
From: Coiby Xu <coxu@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <h4eloauedfln56moljqb724wsiqyhk4gsggexx3tsn4o4utjeu@ieczfooqcqsf>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <CAHC9VhRGwXvhU64Nk5jdmtPfrt9bbkzpLVqS0LRbtN3Q3HhnCw@mail.gmail.com>
 <0c7e94a436a3742003e5e1155a48480d8307a9c7.camel@linux.ibm.com>
 <CAHC9VhS6xWvu5TjjS4MRGFEWxdAhg-Xsf6L+=K0k8U+fgiAtTQ@mail.gmail.com>
 <8646ad03f2f14f45c0ade7c7d7cc148f56d964b1.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8646ad03f2f14f45c0ade7c7d7cc148f56d964b1.camel@linux.ibm.com>

On Wed, Nov 05, 2025 at 03:25:05PM -0500, Mimi Zohar wrote:
>On Wed, 2025-11-05 at 10:42 -0500, Paul Moore wrote:
>> On Wed, Nov 5, 2025 at 9:07 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> > On Tue, 2025-11-04 at 21:47 -0500, Paul Moore wrote:
>> > > Assuming I'm understanding the problem correctly, I think you're
>> > > making this harder than it needs to be.  I believe something like this
>> > > should solve the problem without having to add more conditionals
>> > > around the hooks in kernel_read_file(), and limiting the multiple
>> > > security_kernel_post_read_file() calls to just the compressed case ...
>> > > and honestly in each of the _post_read_file() calls in the compressed
>> > > case, the buffer contents have changed so it somewhat makes sense.
>> >
>> > > Given the code below, IMA could simply ignore the
>> > > READING_MODULE_COMPRESSED case (or whatever it is the IMA needs to do
>> > > in that case) and focus on the READING_MODULE case as it does today.
>> > > I expect the associated IMA patch would be both trivial and small.
>> > >
>> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
>> > > index c66b26184936..b435c498ec01 100644
>> > > --- a/kernel/module/main.c
>> > > +++ b/kernel/module/main.c
>> > > @@ -3675,17 +3675,19 @@ static int idempotent_wait_for_completion(struct idempot
>> > > ent *u)
>> > >
>> > > static int init_module_from_file(struct file *f, const char __user * uargs, int
>> > > flags)
>> > > {
>> > > +       bool compressed = !!(flags & MODULE_INIT_COMPRESSED_FILE);
>> > >        struct load_info info = { };
>> > >        void *buf = NULL;
>> > >        int len;
>> > >
>> > > -       len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
>> > > +       len = kernel_read_file(f, 0, &buf, INT_MAX, NULL,
>> > > +                              compressed ? READING_MODULE_COMPRESSED : READING_
>> > > MODULE);
>> > >        if (len < 0) {
>> > >                mod_stat_inc(&failed_kreads);
>> > >                return len;
>> > >        }
>> > >
>> > > -       if (flags & MODULE_INIT_COMPRESSED_FILE) {
>> > > +       if (compressed) {
>> > >                int err = module_decompress(&info, buf, len);
>> > >                vfree(buf); /* compressed data is no longer needed */
>> > >                if (err) {
>> > > @@ -3693,6 +3695,14 @@ static int init_module_from_file(struct file *f, const ch
>> > > ar __user * uargs, int
>> > >                        mod_stat_add_long(len, &invalid_decompress_bytes);
>> > >                        return err;
>> > >                }
>> > > +
>> > > +               err = security_kernel_post_read_file(f,
>> > > +                                                    (char *)info.hdr, info.len,
>> > > +                                                    READING_MODULE);
>> >
>> > Without changing the enumeration here, IMA would not be able to differentiate
>> > the first call to security_kernel_post_read_file() and this one.  The first call
>> > would result in unnecessary error messages.
>>
>> Given the patch snippet above, in the case where an uncompressed
>> module is passed into init_module_from_file() there would be the
>> following checks, in this order:
>>
>>  * kernel_read_file()
>>  -> security_kernel_read_file(READING_MODULE)
>>  -> security_kernel_post_read_file(READING_MODULE)
>>  * init_module_from_file()
>>  -> NONE
>>
>> ... this should be the same as the current behavior.
>>
>> In the case where a compressed module is passed into
>> init_module_from_file() there would be the following checks, in this
>> order:
>>
>>  * kernel_read_file()
>>  -> security_kernel_read_file(READING_MODULE_COMPRESSED)
>>  -> security_kernel_post_read_file(READING_MODULE_COMPRESSED)
>>  * init_module_from_file()
>>  -> security_kernel_post_read_file(READING_MODULE)
>>
>> ... the two differences being that the hook calls in
>> kernel_read_file() use the READING_MODULE_COMPRESSED id, which seems
>> appropriate as the data passed to the hook is the compressed
>> representation, and the additional _post_read_file() hook call in
>> init_module_from_file() using the READING_MODULE id, as the data
>> passed to the hook is now uncompressed.  Not only should IMA be able
>> to easily differentiate between the two _post_read_file() calls, but
>> it should have access to both the compressed and uncompressed data.
>
>Thanks, Paul.  Yes, a single additional enumeration is enough.

Yeah, thank Paul for elaborating on the solution!

>
>Mimi
>

-- 
Best regards,
Coiby


