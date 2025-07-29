Return-Path: <linux-kernel+bounces-749473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3DDB14ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B4C1707F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33E1A2389;
	Tue, 29 Jul 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN7SSUFQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDF4C6D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797216; cv=none; b=mbv9jTn+nEelQsMUHfHfCTxTzO7BhAFm9Ss0iei1BLIp3HC30XddP5subSQ5WxvySpeivlTx8mc04Y0Xoh8m/XT948xOC21z4GpG+PnA4swbdIvH0OdRmnD57L6mko/Zkg/gbna6cCh6CFs9m/raldH3SSXSuV2M/J+XsFHxsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797216; c=relaxed/simple;
	bh=VkZPXiUUgy2DtOCgrH8FEXTLQFWm2lLISt5zKbLc4/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=selzdmkXIs2dt9QdbNCO8+aU7hw5fFBgZ/QxZmxdl9Qlx425MORQriwZ84wJo9jyun8kXEtD+sLodmlGFgjco0M+liwM4eMRcduEY2dC07Zqhu/cKPQCa00Jl6ZPeT1gH6wQI3BfXaYNgICDWSL7qsiRbcXZoUwSLtXSPLvx9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN7SSUFQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so36785535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753797213; x=1754402013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgD2yooVBQyOgeS/5DXXpBjPnv8zp4QtCnOuo9AiwFs=;
        b=QN7SSUFQgToS8HdoQ9PeGtE9hV7+rc3kzcg5zUPBM31eMczZ439EJPT7si9oq7dFMg
         Y18X4qVUY6ce3bOk2j8Z3N+JlHN+7rHdHvLOcLvuhTLB0g3AJfF0dgUEHEkBLRXV4hL3
         UdnH4d2B6favn5NPGWukw37eoshew84W+Rc17KSxsHiea2RklJzKG4aWQsBbpW5BTBq8
         ZjgGNYiKVr9tOM1H/ftAPcnecmJsMt5l1UTWAhCEKw3Wx3S/bqTLGYRtbpJIoHdXk9LY
         wfflMGgcJL+hkW17IDPDs+SwQ47W88gNJMiFevkME5P/tWJ+6JKts7gJH3mOAMTUa49Q
         c3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753797213; x=1754402013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgD2yooVBQyOgeS/5DXXpBjPnv8zp4QtCnOuo9AiwFs=;
        b=PkzQ83fJlwLp8dwOa5FQqpLGlvtgRqda76oTxNk3BqnIQCIzGHz0aIF8+4P/+i67v+
         mavrBJo2ALLz+rQkuwjmey/4hyTDkNBlykp9F4TYDe72ZQeMXyLlLfXRsQt6K7+7IeBi
         8OWG7wrn/gRM5he8wq8R27rZCtlrA8lPvVEap7TJNFjo3J2Is+d18XM1k1RsbnyVJpG9
         tarilNHcyrO5FYNMZSDFaUdB/+WjZdHZLoSrOirTe8+sBiRRhz7Xgpqn1DFZXKtJ2Ugc
         aV99d+Is6+WYJc/pJ2JgOrtcMu009RunwCLNLhI8S+1lF6ax43j4rdYsLyG0eKmCIIzM
         C5oA==
X-Forwarded-Encrypted: i=1; AJvYcCUwwLSuBOS31h7xrLmoe3uHw5K/Ut+0z5kzmVGF6n8OLq0+Aeh+52X7igSSdiLFjKuO9N3CJMIThXznWbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sRc6n5jaqz4kwdr6ePyxAUrh2SLfmrFiQ9uJ+xdobQMcfzPm
	A39S4oUZD96fDHx0kmcskCv8H2Lms2dq6WVo5+1C8VzWwcam+C6+WczB
X-Gm-Gg: ASbGncsc7Bm4fp0dz985t4IgxbY8nuH6NUmNiEDiL937NGcqB1xygVy717XZ9/J8rFZ
	NhDe3PBRnUffJQL8p5YW0jt9G3AuyjBhPqKB/5sYQOQuHIid65PN5MYT6QzqqCPoYw7K4u8Ohjo
	33XnHzCYTtNOLdlzftGpE0Tlnvu7kTldW6wkLyIp7GGIr/66jv3SDdgsSGcOgQ+Mo5mq4Pax2Jw
	slZfm6Eu4lRtUpOAljtMllQ7Gn3CXGZTxHmEAhkK5/YkSAnUGz+TyhtH8/v6pCwVMaU3gTpdRz6
	56/cOzoo6aucULF3wwijYuXLsfmruCfeS3QwFDQBSfmMBkQUlpNZ4frITTlpyo8ohQ7XS+1AH9z
	az7J7nrVLJfYiRi8=
X-Google-Smtp-Source: AGHT+IFHMRl5Ir2/Kp76P8eHrruh1SxZKxyeKj1sfOFtGFbIp+QsFSa1nhNSdGd9wHFMp24V+d2h1w==
X-Received: by 2002:a05:600c:4f87:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-4587644278emr155376725e9.17.1753797212493;
        Tue, 29 Jul 2025 06:53:32 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588dd4d477sm19668085e9.2.2025.07.29.06.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:53:31 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	PanJason <pyyjason@gmail.com>
Subject: [PATCH v1 0/2] mm/damon: Add damos_stat support for vaddr
Date: Tue, 29 Jul 2025 06:53:28 -0700
Message-ID: <cover.1753794408.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: PanJason <pyyjason@gmail.com>

Previously damos_stat only supoort paddr. This patch set adds support 
for damos_stat for vaddr. Also all different types of filters are 
supported. 

Functionality Test
==================
I wrote a small test program which allocates 10GB of DRAM, use 
madvise(MADV_HUGEPAGE) to convert the base pages to 2MB huge pages
Then my program does the following things in order:
1. Write sequentially to the whole 10GB region
2. Read the first 5GB region sequentially for 10 times
3. Sleep 5s
4. Read the second 5GB region sequentially for 10 times

With a proper damon setting, we are expected to see df-passed to be 10GB
and hot region move around with the read

$ # Start damon record
$sudo ./damo/damo record "./my_test/test" --monitoring_intervals 100000\
1000000 2000000

$ # damon report
$sudo ./damo/damo report access --snapshot_damos_filter reject none \
hugepage_size 2MiB 2MiB
heatmap:
# min/max temperatures: -900,000,000, 100,002,000, column size: 136.564 MiB
intervals: sample 100 ms aggr 1 s (max access hz 10)
# damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
df-pass:
# min/max temperatures: -663,075,528, 100,002,000, column size: 128.037 MiB
0   addr 86.082 TiB   size 682.039 MiB access 0 hz   age 9 s           df-passed 0 B
1   addr 127.225 TiB  size 466.039 MiB access 1.000 hz age 0 ns          df-passed 468.000 MiB
2   addr 127.225 TiB  size 51.785 MiB  access 2.000 hz age 0 ns          df-passed 50.000 MiB
3   addr 127.225 TiB  size 785.219 MiB access 2.000 hz age 1 s           df-passed 786.000 MiB
4   addr 127.226 TiB  size 87.250 MiB  access 1.000 hz age 1 s           df-passed 88.000 MiB
5   addr 127.226 TiB  size 982.719 MiB access 1.000 hz age 0 ns          df-passed 982.000 MiB
6   addr 127.227 TiB  size 109.191 MiB access 0 hz   age 0 ns          df-passed 110.000 MiB
7   addr 127.227 TiB  size 103.945 MiB access 0 hz   age 0 ns          df-passed 104.000 MiB
8   addr 127.227 TiB  size 935.539 MiB access 0 hz   age 0 ns          df-passed 934.000 MiB
9   addr 127.228 TiB  size 386.547 MiB access 0 hz   age 0 ns          df-passed 388.000 MiB
10  addr 127.228 TiB  size 579.824 MiB access 0 hz   age 0 ns          df-passed 580.000 MiB
11  addr 127.229 TiB  size 168.676 MiB access 1.000 hz age 1 s           df-passed 168.000 MiB
12  addr 127.229 TiB  size 42.172 MiB  access 1.000 hz age 1 s           df-passed 42.000 MiB
13  addr 127.229 TiB  size 63.254 MiB  access 0 hz   age 0 ns          df-passed 64.000 MiB
14  addr 127.229 TiB  size 147.598 MiB access 0 hz   age 0 ns          df-passed 146.000 MiB
15  addr 127.229 TiB  size 112.453 MiB access 1.000 hz age 0 ns          df-passed 114.000 MiB
16  addr 127.229 TiB  size 168.684 MiB access 1.000 hz age 0 ns          df-passed 168.000 MiB
17  addr 127.229 TiB  size 810.512 MiB access 0 hz   age 6 s           df-passed 810.000 MiB
18  addr 127.230 TiB  size 202.629 MiB access 0 hz   age 6 s           df-passed 204.000 MiB
19  addr 127.230 TiB  size 206.859 MiB access 0 hz   age 6 s           df-passed 206.000 MiB
20  addr 127.231 TiB  size 827.449 MiB access 0 hz   age 6 s           df-passed 828.000 MiB
21  addr 127.231 TiB  size 326.004 MiB access 0 hz   age 5 s           df-passed 326.000 MiB
22  addr 127.232 TiB  size 760.680 MiB access 0 hz   age 5 s           df-passed 760.000 MiB
23  addr 127.232 TiB  size 148.238 MiB access 0 hz   age 5 s           df-passed 148.000 MiB
24  addr 127.233 TiB  size 592.965 MiB access 0 hz   age 5 s           df-passed 594.000 MiB
25  addr 127.233 TiB  size 321.695 MiB access 0 hz   age 5 s           df-passed 320.000 MiB
26  addr 127.233 TiB  size 750.629 MiB access 0 hz   age 5 s           df-passed 752.000 MiB
27  addr 127.234 TiB  size 73.078 MiB  access 0 hz   age 7 s           df-passed 72.000 MiB
28  addr 127.234 TiB  size 31.320 MiB  access 0 hz   age 7 s           df-passed 28.000 MiB
29  addr 127.997 TiB  size 132.000 KiB access 0 hz   age 9 s           df-passed 0 B
memory bw estimate: 3.615 GiB per second  df-passed: 3.615 GiB per second
total size: 10.669 GiB  df-passed 10.000 GiB
record DAMON intervals: sample 100 ms, aggr 1 s

$ # damon report again
$sudo ./damo/damo report access --snapshot_damos_filter reject none \
hugepage_size 2MiB 2MiB
heatmap:
# min/max temperatures: -1,100,000,000, 300,001,000, column size: 136.564 MiB
intervals: sample 100 ms aggr 1 s (max access hz 10)
# damos filters (df): reject none hugepage_size [2.000 MiB, 2.000 MiB]
df-pass:
# min/max temperatures: -800,000,000, 300,001,000, column size: 128.037 MiB
0   addr 86.082 TiB   size 682.039 MiB access 0 hz   age 11 s          df-passed 0 B
1   addr 127.225 TiB  size 10.355 MiB  access 1.000 hz age 0 ns          df-passed 12.000 MiB
2   addr 127.225 TiB  size 93.207 MiB  access 1.000 hz age 0 ns          df-passed 92.000 MiB
3   addr 127.225 TiB  size 414.262 MiB access 1.000 hz age 0 ns          df-passed 414.000 MiB
4   addr 127.225 TiB  size 706.695 MiB access 1.000 hz age 3 s           df-passed 708.000 MiB
5   addr 127.226 TiB  size 78.523 MiB  access 1.000 hz age 3 s           df-passed 78.000 MiB
6   addr 127.226 TiB  size 87.250 MiB  access 1.000 hz age 3 s           df-passed 88.000 MiB
7   addr 127.226 TiB  size 384.469 MiB access 1.000 hz age 0 ns          df-passed 384.000 MiB
8   addr 127.226 TiB  size 256.312 MiB access 1.000 hz age 0 ns          df-passed 256.000 MiB
9   addr 127.226 TiB  size 427.191 MiB access 1.000 hz age 0 ns          df-passed 428.000 MiB
10  addr 127.227 TiB  size 319.023 MiB access 1.000 hz age 0 ns          df-passed 318.000 MiB
11  addr 127.227 TiB  size 212.688 MiB access 0 hz   age 0 ns          df-passed 212.000 MiB
12  addr 127.227 TiB  size 531.711 MiB access 0 hz   age 0 ns          df-passed 532.000 MiB
13  addr 127.228 TiB  size 541.164 MiB access 0 hz   age 0 ns          df-passed 542.000 MiB
14  addr 127.228 TiB  size 135.293 MiB access 0 hz   age 0 ns          df-passed 136.000 MiB
15  addr 127.229 TiB  size 289.914 MiB access 0 hz   age 0 ns          df-passed 290.000 MiB
16  addr 127.229 TiB  size 29.516 MiB  access 1.000 hz age 0 ns          df-passed 28.000 MiB
17  addr 127.229 TiB  size 68.879 MiB  access 1.000 hz age 0 ns          df-passed 70.000 MiB
18  addr 127.229 TiB  size 42.172 MiB  access 1.000 hz age 0 ns          df-passed 42.000 MiB
19  addr 127.229 TiB  size 134.941 MiB access 2.000 hz age 0 ns          df-passed 134.000 MiB
20  addr 127.229 TiB  size 314.871 MiB access 2.000 hz age 0 ns          df-passed 316.000 MiB
21  addr 127.229 TiB  size 112.457 MiB access 2.000 hz age 0 ns          df-passed 112.000 MiB
22  addr 127.229 TiB  size 50.656 MiB  access 0 hz   age 8 s           df-passed 50.000 MiB
23  addr 127.230 TiB  size 50.656 MiB  access 0 hz   age 8 s           df-passed 52.000 MiB
24  addr 127.230 TiB  size 911.828 MiB access 0 hz   age 8 s           df-passed 912.000 MiB
25  addr 127.230 TiB  size 413.719 MiB access 0 hz   age 8 s           df-passed 412.000 MiB
26  addr 127.231 TiB  size 103.434 MiB access 0 hz   age 8 s           df-passed 104.000 MiB
27  addr 127.231 TiB  size 517.156 MiB access 0 hz   age 8 s           df-passed 518.000 MiB
28  addr 127.231 TiB  size 880.207 MiB access 0 hz   age 7 s           df-passed 880.000 MiB
29  addr 127.232 TiB  size 97.805 MiB  access 0 hz   age 7 s           df-passed 98.000 MiB
30  addr 127.232 TiB  size 108.672 MiB access 0 hz   age 7 s           df-passed 108.000 MiB
31  addr 127.232 TiB  size 212.578 MiB access 0 hz   age 7 s           df-passed 212.000 MiB
32  addr 127.233 TiB  size 212.578 MiB access 0 hz   age 7 s           df-passed 214.000 MiB
33  addr 127.233 TiB  size 637.742 MiB access 0 hz   age 7 s           df-passed 636.000 MiB
34  addr 127.233 TiB  size 102.602 MiB access 0 hz   age 7 s           df-passed 104.000 MiB
35  addr 127.234 TiB  size 239.406 MiB access 0 hz   age 7 s           df-passed 238.000 MiB
36  addr 127.234 TiB  size 513.020 MiB access 0 hz   age 7 s           df-passed 510.000 MiB
37  addr 127.997 TiB  size 132.000 KiB access 0 hz   age 11 s          df-passed 0 B
memory bw estimate: 3.948 GiB per second  df-passed: 3.947 GiB per second
total size: 10.669 GiB  df-passed 10.000 GiB
record DAMON intervals: sample 100 ms, aggr 1 s

As you can see the total df-passed region is 10GiB and the hot region
moves as the seq read keeps going

PanJason (2):
  mm/damon: Move invalid folio and has filter to ops-common
  mm/damon: Add damos_stat support for vaddr

 mm/damon/ops-common.c |  19 +++++++
 mm/damon/ops-common.h |   3 ++
 mm/damon/paddr.c      |  29 ++---------
 mm/damon/vaddr.c      | 113 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 139 insertions(+), 25 deletions(-)

-- 
2.47.3


