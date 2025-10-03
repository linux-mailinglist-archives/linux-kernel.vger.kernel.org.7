Return-Path: <linux-kernel+bounces-841130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B3BB6539
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A1DB4EB3DA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB9E288522;
	Fri,  3 Oct 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfPd0vh0"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F35188CB1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482684; cv=none; b=fKhFVGp69DhSnvENsQ+q/VrD+VYcZLQSSkCj0njOknh8xCzkQPJFNCSI6isBDZOQUKa2iDabyKGLsd9TkYXqVuXllhPoWui5WY9+PFMCtHMTzzA6u3Vm3fQIOeChK9rZS22jzI4VUGTLNNb10Onk0IaqByUfR1MVIa/uWDckre4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482684; c=relaxed/simple;
	bh=VfiCAGN0AGfa646ltsvQvSU2Seqpx2og6lu9lSfJWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugwjUSsAETfh8/BrWs3lB/shV6eJx85QMzZE4/Px7551bxPq0jcqGAkUEDm32Wn+KFdgEmexLa4dy8hbUuhdnoD9vaFfAeESMAz4VxRlhKF2az///MwWy53hqTisUtBPpxNQV++7GrpVj2nrjiu4xGa1q0MVm85/rxT5E7fEidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfPd0vh0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-368348d30e0so19781731fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482679; x=1760087479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTLAmAkT0Bz6x7mi9MjbZErT4JQSvAEF74DuHT2XEq8=;
        b=IfPd0vh0R1NzQyZBXlGkHO2bi3GIRFXxH6oWp6YdU5q5/xfpOkeq1nzGh0kFMsPhbJ
         2MkVKP+kIBDeS2JS5MpfNxmeGG9uWNlqk3zNNs9joNUvxlErd46thPzRFeZcth5ERF4K
         qwpe2s6xo593oOiggD+Dx3VycsKJU+HxR9iCPVWTx+yEzxSPy1S0T6HrFU64bTyd0ARI
         rFmVmAnDt0pw2ZWfzj4jvVAtpHqdFqG7xl6QcIVaEAlGyJYxmUet/OkJjq6UUGRUmim8
         V2ZKEnGALhvvoYoBH/klepHXGlGHBuOX0GIlbkw/wZ29ml3NksSOKzy4AD1FNDq+XSfv
         TWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482679; x=1760087479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTLAmAkT0Bz6x7mi9MjbZErT4JQSvAEF74DuHT2XEq8=;
        b=pDJUOvDo0BgR6u6qjFR/2lGpQfqz1VWQaCWzUDcYgFuMTSMUXpBHqA3ceOsnOImMdE
         3WV7iTvGyZIU1I0vdDkeLr+Nn0jkQh/WKAcH92vV0TqLHT8dy3O/ytVwpOQf0rK8h3lc
         sfmho9luVJZDaCFGXbE9OQlp4RFQFBYHKoZYj0bU+O8IbNIlpHmGuLF4Sal8aUdbrgHf
         RW55p1YOJRdu2Wf/b/WmLKw2fIJ4n0rzbrHlqkM2SJ89MfaIfcQUVfoffnP9qxBKnAF7
         w6005zNfndO3xWSwgoWMZWz02F783LWSUApkOEH1GuenVXCJHgzkAMpKsTQXaGfAGS8q
         5f7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXi1ptxcuII0Xn26ArBS3HufTyzYsUmc9RmOlrxJSwj6DjntabNK7A4w0ZAEAd5GviCZH+EGAKpplMWW00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWq4p1B7ZVSpE5Sy0D6oKMpN8LgOTJxf4zMXoPuCsh+9+s550
	R4BMoyVYVBDvortZBOiai5bUxdpRwbBMbZzV53LgWmPE8rI7yjP91X8+
X-Gm-Gg: ASbGncsvKK4pGgbpoEjoyYcgLI/rq2aQStXAMXBNJHvqmOskguqIBcWq0y0Vs7eQHit
	vvBu2b08WyD+gs1v3e0OlE3BBGHFQ20w/tRIFJK3Q27swbQnwknfM4Rs+3ns4Zj4Eom+7UC7ULP
	F6sN9H+DjOC3hZCBeP8x7UVWe328nU3X/FdOJ00DaAKymt3oiAmkZX91K/llZ6Z808qezL2slY/
	K9VCGcjZ6iDsswDOMcDtcj9j+Hyrk6LzBmjkzGPFMe6cqug1/+l3lbeEEDa1qCGiZ9DFmGuPrST
	RVWBl5L+kKdFxECfr4m6BU7vM1/iA1dnYLyFjAVSQjK9v512ksvmNOMmlaZpzof7MYNuftfH/9T
	PpE0wN1ATXpKs/ZCQ9QvVoltfFnn4Ej5swv7ElhbD9e9pmXFXiFQxiVwDNafFE9LRWnGIP1WmSh
	mZZl26yTjuLyc=
X-Google-Smtp-Source: AGHT+IEE37WjpVP/WIvXAgeGS39Gce9Ezt51xjGTSJsmxeVSfCWvxIo+dLGFakcwws5UpIYrgxmgHA==
X-Received: by 2002:a05:651c:1992:b0:372:9992:1b0 with SMTP id 38308e7fff4ca-374c3823058mr6029241fa.31.1759482679187;
        Fri, 03 Oct 2025 02:11:19 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:18 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v3 0/4] NFSD: Impl multiple extents in block/scsi layoutget
Date: Fri,  3 Oct 2025 12:11:02 +0300
Message-ID: <20251003091115.184075-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for multiple extents in the LAYOUTGET response
for two main reasons.

First, it avoids unnecessary RPC calls. For files consisting of many
extents, especially large ones, too many LAYOUTGET requests are observed
in Wireshark traces.

Second, due to the current limitation on returning a single extent,
the client can only reliably request layouts with minimum length set
to 4K. Otherwise, NFS4ERR_LAYOUTUNAVAILABLE may be returned if XFS
allocated a 4K extent within the requested range.

We are using the ability to request layouts with a minimum length
greater than 4K to fix/workaround a bug in the client. I will prepare
the client's patch for review too.

Below is an example of multiple extents in the LAYOUTGET response
captured using Wireshark.

Network File System, Ops(3): SEQUENCE, PUTFH, LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    minorversion: 2
    Operations (count: 3): SEQUENCE, PUTFH, LAYOUTGET
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            layout available?: No
            layout type: LAYOUT4_BLOCK_VOLUME (3)
            IO mode: IOMODE_RW (2)
            offset: 0
            length: 10485760
            min length: 16384
            StateID
            maxcount: 4096
    [Main Opcode: LAYOUTGET (50)]

Network File System, Ops(3): SEQUENCE PUTFH LAYOUTGET
    [Program Version: 4]
    [V4 Procedure: COMPOUND (1)]
    Status: NFS4_OK (0)
    Tag: <EMPTY>
        length: 0
        contents: <EMPTY>
    Operations (count: 3)
        Opcode: SEQUENCE (53)
        Opcode: PUTFH (22)
        Opcode: LAYOUTGET (50)
            Status: NFS4_OK (0)
            return on close?: Yes
            StateID
            Layout Segment (count: 1)
                offset: 0
                length: 385024
                IO mode: IOMODE_RW (2)
                layout type: LAYOUT4_BLOCK_VOLUME (3)
                layout: <DATA>
                    length: 4052
                    contents: <DATA>
    [Main Opcode: LAYOUTGET (50)]
pNFS Block Layout Extents
    bex_count: 92
    BEX[0]
    BEX[1]
    BEX[2]
    ...

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v3:
 - Added a Fixes tag
 - Removed an unnecessary sentence from the commit message

Sergey Bashirov (4):
  NFSD/blocklayout: Fix minlength check in proc_layoutget
  NFSD/blocklayout: Extract extent mapping from proc_layoutget
  NFSD/blocklayout: Introduce layout content structure
  NFSD/blocklayout: Support multiple extents per LAYOUTGET

 fs/nfsd/blocklayout.c    | 154 +++++++++++++++++++++++++++------------
 fs/nfsd/blocklayoutxdr.c |  36 ++++++---
 fs/nfsd/blocklayoutxdr.h |  14 ++++
 3 files changed, 147 insertions(+), 57 deletions(-)

-- 
2.43.0


