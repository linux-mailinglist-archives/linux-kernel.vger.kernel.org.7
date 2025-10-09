Return-Path: <linux-kernel+bounces-846703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57796BC8C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7D4FBAB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206412E62C3;
	Thu,  9 Oct 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwxMeBlH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5E2C21F1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009068; cv=none; b=REk8i5TCY7yJMXAWsnl82JbMP6MAAUBEegxqJ2zKMU8la5hUGhGrnt8xn/9+b1ReFwotODK6k/uXja+hP9Rkhu1sP0iHcEx8KhobQFlN/fkewvaxxQm9dRYRwhf4bNTNbc/OgSaCK4L32SJTayiITk1tCtXnb1un/c0ESnUdnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009068; c=relaxed/simple;
	bh=oT4tl3z2KUhw2+Hd2uYG08IuzT7jBpBGLw7mqIhBV7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aU8bgR4H1vqewwbAFL65gOMhWn0tXSzcMMqXlZFwkPiiA3WTtGTQT/wk4bjrzHM4frvmMu60pDcJgQ1iFalLsZqeyYcjLkB+m1uvlzlv3KfRGVSHYK6zW0w4lQLkeVB09C+hTGZAJXQybWxQ8fEXJKKOhi7UCQHdxJZnMHGFY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwxMeBlH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760009065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2lJGNEg2UpjFWdrk/OIO5zgtw0B+C7GNTQdtLNs5Urs=;
	b=JwxMeBlHZiymCfCC9QdRbOfiv1BSi9QGsU1kahs8HlQhEyRXbNrKmAL+trkLDOxbsLoE0n
	8m9YCHJqEU5LHE4PGZLrHeRORLTcyHPI9UAdbMsaGzpxrrlqutWWP2RYoXi13wgDh/4N5x
	JUvnD6q1KmxCK4LPBGiJaG5SLPLr2A0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141--T1vAAFpNPisbolrPT5iAw-1; Thu, 09 Oct 2025 07:24:24 -0400
X-MC-Unique: -T1vAAFpNPisbolrPT5iAw-1
X-Mimecast-MFC-AGG-ID: -T1vAAFpNPisbolrPT5iAw_1760009064
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8589058c6d1so145692885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009064; x=1760613864;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lJGNEg2UpjFWdrk/OIO5zgtw0B+C7GNTQdtLNs5Urs=;
        b=SOYucYSFR1d1cF/EC5jINBhUr0KMjkX+sQSkG0tS0PkTN3IZfxJhgPHcMYJMBg5MDP
         4Qyr9CZDqKIfQa/sDfABLE51HIDL3pXfRu+Ak8klSZHQkeFWLKkaZ0NimcKYR8xvGs78
         GHEhfUwZLAHKJU784UxWmQjcOcINoY83v6gcXiqnZEpLZHrmf3dLR6wjnpbygKRbS42C
         9678BZLu5rUNDZQiIN87puf1IczQhiXsYaAwp78CwDuZiJXeZ8AAjr9OvrF8Bt42r9Yj
         4H2BCGlIXXkCU7Q/ZnoarQCZCnIQj632K72U+ELKyEMJUmh2w95BS9RG9Qfg3LkUOo9y
         PAfg==
X-Gm-Message-State: AOJu0Ywbh3AX78x7xUyG9lnNHRIVoCDC26GG219gVqZDBHKEYzkD6igT
	JsMMb01qzjSwxdjV4Yhoet4AS5aY/RlOgQ7P/iPe8C9Y6yeBCqFRzReXIK7wx2U4eJ8RYRVcHDl
	SIRp+GUV4aBSZ6C/L5U224gQim63WMOLSa7rsLdP9JqpRLjv8VZp5kOI21f+ojUZRMoYolMTs0M
	4lVG7FYIz4Wbh+q6KUT22H5pSF0S8ys620IUilucwPFaI=
X-Gm-Gg: ASbGncuseAWb76jfRlhEfrRZiYsEIBLXJnWlVDbyTDmhcnEoa3LzE4XHITIVMssQQJt
	u2JoT9a8x6MUMXPo29vUCKIYJnxRUWFcnW2cIvPIvN+Ymg2LjAI87uw4zK6XD8rw0OGRAuxgK1u
	NRLFSlOG8pVz3lZEpa8RHeyudIFDeC4FfHAL89sbWR4+dKTGuw6Z+6Eq9vBSzGPaFyU1BWlfjgE
	BhnqmO4e9O3NviooFCbimo1ar9WjJ3LlKc7YC2XQTAyulYyOggcROYFKKJxKVZ2HPSh3ip5fDez
	no3u/zp80ozcrnDzZveC2y+oOCYiPPvZRGw=
X-Received: by 2002:a05:620a:a216:b0:883:b9c8:5829 with SMTP id af79cd13be357-883b9c8642cmr644633485a.77.1760009063919;
        Thu, 09 Oct 2025 04:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0mTtYplLadpOj/nejAdqueSbh8n+h7GZD/IgFvS6ckr5aGy+wTOd/VbqF6jWjV3J9f1dabQ==
X-Received: by 2002:a05:620a:a216:b0:883:b9c8:5829 with SMTP id af79cd13be357-883b9c8642cmr644629585a.77.1760009063306;
        Thu, 09 Oct 2025 04:24:23 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2274482sm173791885a.46.2025.10.09.04.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:24:23 -0700 (PDT)
Date: Thu, 9 Oct 2025 07:24:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/3] feature related cleanups
Message-ID: <cover.1760008797.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent


A minor cleanup around handling of feature bits: this fixes
up terminology and adds build checks.

Lightly tested.

Michael S. Tsirkin (3):
  virtio: dwords->qwords
  virtio: words->dwords
  vhost: use checked versions of VIRTIO_BIT

 drivers/vhost/net.c                    | 14 +++++------
 drivers/virtio/virtio.c                |  8 +++----
 drivers/virtio/virtio_debug.c          |  2 +-
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++---
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_features.h        | 33 ++++++++++++++++----------
 include/linux/virtio_pci_modern.h      |  8 +++----
 scripts/lib/kdoc/kdoc_parser.py        |  2 +-
 8 files changed, 42 insertions(+), 33 deletions(-)

-- 
MST


