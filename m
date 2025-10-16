Return-Path: <linux-kernel+bounces-855980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3EBE2B85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B28FA502345
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666F2E1C61;
	Thu, 16 Oct 2025 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amnLWnjS"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4609328603
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609634; cv=none; b=tntMTWLTcLqNtlJoqV8aM5N6K2MUJm11mhaiEEbdTQWtXOCyNrbCoaCq+rZsZZeHkupecO7Gna8rMoP4brl+0k4fAJSOi0EqKpTV/C3VjhPgRhCCn2x3A4i24ToqBQR6IEOpILpOFHN1VbIvQgqCGg22mD+JQcYx7Pd6gJ75qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609634; c=relaxed/simple;
	bh=Jl788zXICHJ5acrAZyD/a37MrSRcVADO7fQVKMuIvDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X0pZnUDnYYqTOgqN6ReYjZeuWE0Xj4HXCJZe74B9zChWRLxyE57f4ri+9pHPeo7jTO+88dTqVIDrQVxRjRKlWRwCF8mQC3hYRPbofro9N41wP4kxBhJJ3ZTm2apZxwhWDi1WpMn/8QgcNSmdGPyOhkJkmlbQkXhgfqTi/HnxM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amnLWnjS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7810289cd4bso587752b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760609632; x=1761214432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq8OW6TGbxrBXRjrgbfzJXwoQLqOW1xHiJ8eAh8jstY=;
        b=amnLWnjSbbOqvsSnLuFG7s1CoRvBEF8bvBuGqo3mxlP/XaxLuG+QTb6sikwtGcyxNa
         GegbH3fFt6JGPT46BcNXXKNVj4VKjw/lZKhy5BHW07os4eHr+LrRRsZ324J+A3E59nXD
         CeB+tuQu3WHHLXoQqhzMS4Ku3O3VlNGbCEUKLztWqtLrJRz8gFd9oR3axgEcjrYTaIP9
         //GSmZE9LsHKenWR8FuaWM/gX8f+Rx/Ew09lxMISmZ1BpoZhXN1Hnufy2RwwdeW4eHyy
         nM9Wv5WVnNquxmUSbUzVUrB+qgWnHvd3F2K7wJ0BRkKBWOIEzjh+e30OJC7CS5LpVq0T
         J52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609632; x=1761214432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jq8OW6TGbxrBXRjrgbfzJXwoQLqOW1xHiJ8eAh8jstY=;
        b=iuZRdqW5HXnC2dVr+OTXLta8w/psu+pgNaW8NjcWZkyYwE/rqlKVfWMqAWtO00IJSp
         3hyV9rJXSExWBz222S9KFzyjTgSyigK92k6M3MPrDz1cJYrqRNhS1/4HjVNXmAZMUXPj
         9mSlLktAvbQnw4Efm/1nmld8l9UGjsl/Ln+6fGFv66TOmyVTnA5EDu6OKPZW7Zg3RwTj
         RMiNzXKsROn0QDy2GM3BiTW52S0DSvEbtP7L32HdatMbsyPnBQ8Qba+/t94+bGKMFPS9
         pwpcZEv3KdJxoqt1X/UPy5ICFZ5loi88mT4jBArKa/+l8RIz0sMArEdgGMD/IPoDQ06Q
         CgxA==
X-Forwarded-Encrypted: i=1; AJvYcCX+6udaPybfUE7264h+MLdIBQs0OZG2BUh6pvtEgD0LoOb/ohSGQhFBvmOFxIl4bflMsnszKTZne0RLDyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTojcEiU6kUriNwJXgUmNFSRlWtpZXF2VlecpcpYUUdXz561g7
	vYAbO9c8XrvhGaLxjXOLBGjyIUpN7qj5AUCAWIDEEtHyxaaJAqK7HNIr
X-Gm-Gg: ASbGncs1/eN8OiVK7T41ZBZSvrkQgxwutrKxIkd1OM0q0uoQ57l05eCbVQtpl6r29r4
	s3SNU8E+UH+ye+xdnZLHprHhj1faUIbM6wUBX8DBqbFNWUoZTx0OMjjaBJt4M8Em6nIpyYm7lYQ
	CtcKfcKU2p/FiOV/Lwv5p8cRmT9QpkSlYfb/MmU7zqIIDsz32VTaHSk3z5BlYS5O1KNRHXoZX//
	4WX4u6GmLiEUaKRvC3zsIQ5ToJphfS+8SfmpcVg4QO1jT2mBkEZhuMnLofgItEKy8BBaTqbaCqj
	Sj71i5gxDKYyAMPmWT6Pb8gzLsS3pXrgqe5TCPB3dFRK7JZa+KhnN4f+UljWdtKPumZsImxpjOr
	NjWdV/YCtDKlWJgOjqtva1W4UD2oJVGz6dF19eUz9mgB/1+zixivRnimPTwblhivjkYU9f5ovew
	==
X-Google-Smtp-Source: AGHT+IG8QZYlL4nYUg/eotHES9Ezn/ZamnzArtEteyIfhrKsS2XovswaFPXwaQddIH+JOobnNopYuQ==
X-Received: by 2002:a05:6a20:6a29:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-32da845f7afmr43305814637.46.1760609631920;
        Thu, 16 Oct 2025 03:13:51 -0700 (PDT)
Received: from Shardul.. ([223.185.43.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288bd55sm2354263a12.9.2025.10.16.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:13:51 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: shardulsb08@gmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf 0/1] Follow-up fix for potential error pointer dereference in propagate_to_outer_instance()
Date: Thu, 16 Oct 2025 15:43:41 +0530
Message-Id: <20251016101343.325924-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi BPF maintainers,

This patch follows up on my previous submission:

  [PATCH v2 bpf] bpf: Fix memory leak in __lookup_instance error path
  Link: https://patchwork.kernel.org/project/netdevbpf/list/?series=1012189&state=*

During the review and CI discussions for that patch, a potential issue was
identified in propagate_to_outer_instance(), where get_outer_instance() may
return an ERR_PTR (e.g. -ENOMEM) that is not currently checked before use.

This patch adds a simple IS_ERR() guard and returns the error code to prevent
dereferencing the error pointer.

Thanks,
Shardul

---

Shardul Bankar (1):
  bpf: liveness: Handle ERR_PTR from get_outer_instance() in
    propagate_to_outer_instance()

 kernel/bpf/liveness.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1


