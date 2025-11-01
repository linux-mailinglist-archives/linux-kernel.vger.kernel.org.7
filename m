Return-Path: <linux-kernel+bounces-881179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29EC27A64
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BDB1A2672A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BE289378;
	Sat,  1 Nov 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgyagDq/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="blen2bGG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6E72618
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987655; cv=none; b=Iaj9KMV2oy+52fCUfAKMAesti2DBBiqQfU4lwyOdCjbHRgsxjgi9fYxCBxXgo88u2+3X+Lt2c6hdui6UZCu95DH6mY1X+7UYhSm74LFoqHqvEncVCNfA8QC1YWWImraOovxvcmm21bMC4xpyA/4v4dGnpW1aaE3eu1nQPFxMbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987655; c=relaxed/simple;
	bh=erZlZwmG67hxS99lC1J1OI9uGWwNY/GeBgK/oj0OKmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdm4LeRo/Y8h0fKbjCddhFOZK1yVcIDkMgESgU7NCD2FRy2j97Gh179rfZM3lsvWqfq8EB8HtA0X81psVpH2L1PmWzqK/yw/S2rde4JBefbi2kQDFZ1/2qs4Qyt6wmLbuOKQTGNhTV4IkP5wHOQj/9UdoNtuuQK1G016o+n/dV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgyagDq/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=blen2bGG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761987652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn+afpMdtbihpSuxES9QlBr4zxqcZucnzgZEXoXLmqk=;
	b=IgyagDq/CitjMgUDhbljgaQGZ87DPt9eN08cSoIdeVepxtbzCPBqeGnqT6V4E28WSPM7Ly
	tkT97vHIW6ThJkecNJdM02mWaFWPzL9pnssdEEXJWEh3RFAlRALL8hL0rg5qjAxlDKOAHW
	cEioMENsNTrHLU28ynXCR9o4H8Dt3wM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-bnwWuaKIPf6ISv5pOthFsQ-1; Sat, 01 Nov 2025 05:00:49 -0400
X-MC-Unique: bnwWuaKIPf6ISv5pOthFsQ-1
X-Mimecast-MFC-AGG-ID: bnwWuaKIPf6ISv5pOthFsQ_1761987648
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62da7602a0so2362281a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761987648; x=1762592448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn+afpMdtbihpSuxES9QlBr4zxqcZucnzgZEXoXLmqk=;
        b=blen2bGG23EME1nloT8jfpM7moyTZH6nR6Rc3wqpblDIBzZPJPkSnvCdqLFB487s+X
         mLsdTw4HcPmI1qF4E+7F2EzOvmLXl0A1gzWgAY/pBcblh7MhJm319Y8Peipxin4Y8+4F
         dKLMwk9mSTelxQ79/t8cPJv+WScaMQG23SefCXKpQV+FYOTm83A+bbznSbdkHqLLSEaU
         wZYojmNnG5Zg7LkhkDneT0iBL85nEk0pCPuJBaBpsXpUpFUydv4SCLzzV/JIGeIJynp8
         SQAjVagznDlG1W8SdR9cg5u8OgkYftBfMUqe3pIe0eBj9SwNqgaU6EjQUVhCnO0nFXQv
         chyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761987648; x=1762592448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn+afpMdtbihpSuxES9QlBr4zxqcZucnzgZEXoXLmqk=;
        b=U0fleYCGtOD8Zd8HFI0fZ8tME8W9JtGjon+qs4VWmjAm+VVvEZZaaeqE0oOH5LQWUr
         CPQxdcyKV5ku9SJL7sqmQvkBiYbZ2QxCN6sn9An4obTI8LmGx+1tmVyCqL79o0LkVhnB
         jrdICPOnCzsrZ/eW5laCqgugCV7ZrzyQ5vNur4wZbGFnd1m/xs8Wx3gpZvS1jSXwkmbj
         9W5O7UxoLGyDWqweNkNvauo0vXL2ffb5XLsHyZIfpJLyRHbiuw631ENsfdhAd3IIpXKH
         6pwI8Cwo2S+baikmEvazcvZ8Y4refa8B8UcRYH0B2buCwtQxhZo93Pg2B8TifqClaMOd
         dDQg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJI5Fi3P1R1gICIkiYTODHWz47/eN9nbwEHyAEjueE77ddDSjIcgoDAMaJ2f8W8QHAIEdXq9a2uuiRbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfHHUeyM8v6YuFNrnINj7NHkXSlCEbUn4xTuGJ34Dp+GRx/pM
	OsPnQGchcWnqfJiYepfRNHLyrEk6y14N5KJKWMUuZxq8jS+EzdNaw0gQVawWYakCf5auPCHLcG2
	XXgf9JsDG/CeN9/TU1OAUzoxlz/8F2RZ48SFcmuomzGxrPtWvb2wRkbAXP8S3b6Sa3g==
X-Gm-Gg: ASbGncvZKLqk3tNjkDlEbNY4lvJPjrIXyp6blmjQeKyxu8RdxYHSi2ifK7jyBs04iAe
	7oEcTYBjf+Y2nJUETMTYaHfLRa+8vIY35oc/XyhKw7x9mP5nHtmIm1BcIs/5OBJ1qrHx3hOzMS2
	0XS22L9+N27d+0TNCA68LfXGoyoXT/egWSgXsJXsZ18kb1RYhe5kJStuGA0qMPVIjqKCQh6Jen2
	/RtODSakHJjhaMtHZwSS6Vh7rSwHCZYIkTZ+3YejG5/y2taiTECZCezOatuqac48qZNG/KUE4E3
	4O/6ug1neV0updvlr4GA0MUb0JDgh0lv5YakkRakCmcGonzSueerExLgAmKMwLNy1zdzj0gRAFO
	/KSf+xj50vLgH02mBflYsghJl0qBSv73JV6VmcE8=
X-Received: by 2002:a17:902:c401:b0:295:595c:d002 with SMTP id d9443c01a7336-295595cd1bamr11607055ad.15.1761987647762;
        Sat, 01 Nov 2025 02:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWfYSpqPPKZTWZUIuCP9sZI3ZFUiApsjI7S0Dmb+QGZeLsda0a9cQgrC17lhu6wzKpF6jaeg==
X-Received: by 2002:a17:902:c401:b0:295:595c:d002 with SMTP id d9443c01a7336-295595cd1bamr11606135ad.15.1761987646798;
        Sat, 01 Nov 2025 02:00:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29556d61c4dsm16365525ad.56.2025.11.01.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:00:46 -0700 (PDT)
Date: Sat, 1 Nov 2025 17:00:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/12] generic: Add atomic write test using fio crc
 check verifier
Message-ID: <20251101090040.6ukcaal2c55ka7wy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <3c034b2fb5b81b3a043f1851f3905ce6a41c827a.1758264169.git.ojaswin@linux.ibm.com>
 <aQCQFOtjhyzohgnA@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQCQFOtjhyzohgnA@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Oct 28, 2025 at 03:12:44PM +0530, Ojaswin Mujoo wrote:
> On Fri, Sep 19, 2025 at 12:17:58PM +0530, Ojaswin Mujoo wrote:
> > This adds atomic write test using fio based on it's crc check verifier.
> > fio adds a crc header for each data block, which is verified later to
> > ensure there is no data corruption or torn write.
> > 
> > This test essentially does a lot of parallel RWF_ATOMIC IO on a
> > preallocated file to stress the write and end-io unwritten conversion
> > code paths. The idea is to increase code coverage to ensure RWF_ATOMIC
> > hasn't introduced any issues.
> > 
> > Avoid doing overlapping parallel atomic writes because it might give
> > unexpected results. Use offset_increment=, size= fio options to achieve
> > this behavior.
> > 
> > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/generic/1226     | 108 +++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/1226.out |   2 +
> >  2 files changed, 110 insertions(+)
> >  create mode 100755 tests/generic/1226
> >  create mode 100644 tests/generic/1226.out
> > 
> > diff --git a/tests/generic/1226 b/tests/generic/1226
> > new file mode 100755
> > index 00000000..7ad74554
> > --- /dev/null
> > +++ b/tests/generic/1226
> > @@ -0,0 +1,108 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 1226
> 
> Hey Zorro,
> 
> Thanks for picking these in for-next. I just noticed that the test
> number for this test has become 773, but we missed changing:
> 
>  # FS QA Test 1226
> 
>  to
> 
>  # FS QA Test 773

Hmm...weird, I change the case number by running `./tools/mvtest generic/1226 generic/773`.
The "FS QA Test 1226" should be changed to "FS QA Test No. 773" by:

  sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"

I'm not sure what happened at that time, I'll check if there're more "wrong number" issues,
will correct them in one patch. Thanks for reporting:)

Thanks,
Zorro

> 
> 
> Commit: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=1499d4ff2365803e97af3279ba3312bba2cc9a80
> 
> Regards,
> Ojaswin
> 
> > +#
> > +# Validate FS atomic write using fio crc check verifier.
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +
> > +_begin_fstest auto aio rw atomicwrites
> > +
> > +_require_scratch_write_atomic
> > +_require_odirect
> > +_require_aio
> > +_require_fio_atomic_writes
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +_require_xfs_io_command "falloc"
> > +
> > +touch "$SCRATCH_MNT/f1"
> > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > +
> > +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> > +threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> > +filesize=$((blocksize * threads * 100))
> > +depth=$threads
> > +io_size=$((filesize / threads))
> > +io_inc=$io_size
> > +testfile=$SCRATCH_MNT/test-file
> > +
> > +fio_config=$tmp.fio
> > +fio_out=$tmp.fio.out
> > +
> > +fio_aw_config=$tmp.aw.fio
> > +fio_verify_config=$tmp.verify.fio
> > +
> > +function create_fio_configs()
> > +{
> > +	create_fio_aw_config
> > +	create_fio_verify_config
> > +}
> > +
> > +function create_fio_verify_config()
> > +{
> > +cat >$fio_verify_config <<EOF
> > +	[verify-job]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=read
> > +	bs=$blocksize
> > +	filename=$testfile
> > +	size=$filesize
> > +	iodepth=$depth
> > +	group_reporting=1
> > +
> > +	verify_only=1
> > +	verify=crc32c
> > +	verify_fatal=1
> > +	verify_state_save=0
> > +	verify_write_sequence=0
> > +EOF
> > +}
> > +
> > +function create_fio_aw_config()
> > +{
> > +cat >$fio_aw_config <<EOF
> > +	[atomicwrite-job]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=randwrite
> > +	bs=$blocksize
> > +	filename=$testfile
> > +	size=$io_inc
> > +	offset_increment=$io_inc
> > +	iodepth=$depth
> > +	numjobs=$threads
> > +	group_reporting=1
> > +	atomic=1
> > +
> > +	verify_state_save=0
> > +	verify=crc32c
> > +	do_verify=0
> > +EOF
> > +}
> > +
> > +create_fio_configs
> > +_require_fio $fio_aw_config
> > +
> > +cat $fio_aw_config >> $seqres.full
> > +cat $fio_verify_config >> $seqres.full
> > +
> > +$XFS_IO_PROG -fc "falloc 0 $filesize" $testfile >> $seqres.full
> > +
> > +$FIO_PROG $fio_aw_config >> $seqres.full
> > +ret1=$?
> > +$FIO_PROG $fio_verify_config >> $seqres.full
> > +ret2=$?
> > +
> > +[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> > +
> > +# success, all done
> > +echo Silence is golden
> > +status=0
> > +exit
> > diff --git a/tests/generic/1226.out b/tests/generic/1226.out
> > new file mode 100644
> > index 00000000..6dce0ea5
> > --- /dev/null
> > +++ b/tests/generic/1226.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 1226
> > +Silence is golden
> > -- 
> > 2.49.0
> > 
> 


