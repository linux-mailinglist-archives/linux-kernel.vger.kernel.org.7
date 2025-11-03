Return-Path: <linux-kernel+bounces-882814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E513C2B929
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A1A188D571
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E683302141;
	Mon,  3 Nov 2025 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/jNm8n3"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E73093C6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171660; cv=none; b=QKv39XmqUAn8uzZmgYqjpJG5vJb0jgMB248CVIMA9rzTTg+n1L0zqmMirx95ivR8zvdugIs3zzRIxGpzeQ27M8d+2YuxNJhu1l72znHV4HvYZIdDTcUl70Klq9BRohXwWgemxhaHmDUKxL2dy7D8ApJWinTYFfzP/fdhh4NRpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171660; c=relaxed/simple;
	bh=HDgFH8+lcYGTIPsMGp8pD2rOtin1LQuwHRYPV0vyMOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kU3VLwYShnXbfziflyt/eQYyBWtS4KonqBY5eis3mNRzWVuPOyKi3wVvQQ/eYz1wCGtYseG9iKz/T9ITVirqYWDsx6wSJFnrNRT3bFPRS5S6xjYaNOvXIZOquR4i9cfOFYOvxrPICgmVPUdMp6Z9+hJXsUriYrJafEWFyn4Zx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/jNm8n3; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-33e27a3b153so4137351a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762171657; x=1762776457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBV8uCibKMjflLcauf2cgohnqF8noUoexoXvof5RE6k=;
        b=N/jNm8n3Q4TDdu1jT8LVzrngGETCcGxqBev7pVMEAH1b53yXXMDZFCQprCzpmbBDfM
         tAswHxsmR9WXe23WGFerfwMOpXPp+SkXNoEQ+kyRJG3X/rcQrAUH3akCfoo0WRHjfBBj
         /HcJfnRv0QAGh5k1zgIX6Ld73HvA2Akf4XfCBV6zLhBHIQj/EP6bHwYxRatewvGzs4jR
         y7mblMMDegRgruHPRIS93PAv4xlcDcz9bSdF1L4Orrd6Drd8OaW5GSylgnPJfz4z4wN+
         DdXDtYVtGxwYNZkytFmQarzzAulDPvJgWZNbWLq9YBwy2Lo0dHzrYqsaI8+VmD8fl7NI
         ZqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762171657; x=1762776457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBV8uCibKMjflLcauf2cgohnqF8noUoexoXvof5RE6k=;
        b=wwMNVQQz+TBuRCwb2PpcwXCr5xBJHrBEyOqI6NnLZpSd0cKAb+xsmcb1T0gs4xKs5B
         KUKBCThse5an2XOBQmwDxky5mQpyuiKR3IWG3r5/gI+PTFxfs6Sx5JBJ+JBrdUfiJ/oW
         pgpZp39a22IwIzok3ZrmNKjHMwzGnu7k95wJOvCCstPvSEkX1yKjEjQQicMAX1613uI9
         +viPMGPhhyZkEcIxyk0MuR9pNo/QtN7fQ2q14howCBJxlctME7V4l1xnX+ZLTzXjPVM7
         GfTBd7Ne5ypKqz2jcn1x7YnJKWzd3EWlD+mglr8ia4o5oCt5Q++JNN7IvfYxrDba+yYF
         zPew==
X-Gm-Message-State: AOJu0YwhrGodwsBFayEOqz6YNOAUIxtBIQJGafF9ypRK3V6mxKzH5FjP
	/D/PS4/y7EH4weJBX7kWLkavOJIzTX0PxluekCiFUQ/nTWCtl8lfsrDjJ/Qq84Q2MKY=
X-Gm-Gg: ASbGnctEBREkNp4Yy7regUXIosEf/sQsycZkDY4R5TLRfWntV3o0yKXXO1ub72Y5PjO
	peRusyKdT9Cc+FaoTMuyIPDxNtCnSG2guI0JVeoY7E08sRvGrbm9m9WB7ivSCDIvfHsVEIMs49q
	vxjoOGF9Y+K1zXgqvkmB2SmBRpC7y7gyQhYHZ1u0R/wlk4vQcNRC146y/dRcvjPkMrbCZCiARMk
	JyHm3GiFOVTkyNZP/6zsdm3oKgrUt886ed5y2xMfkq5GxNQ0YtSO9SuO2RQMo5QWubiro0lewv1
	qLm5IHkJeUjmNJywaPXrxanR0tFExmBoZ/3d6P7OiGojyQqSXb75b2zGSg2YcQ2zmARViWTlSDh
	VmDSx2iq0VW6KbjX7B4aM0Sgmw82GWnAY1kKadDclmSU9ufXsXnmKqgcQWtHYJPpOhNeB08vwru
	7glI1sC/poqhyMrsY3ZKa6hzXJuJmkFrdEb8MLvPw=
X-Google-Smtp-Source: AGHT+IEZfSB9HYZQPKGGoO7TtFh1e+B/9EFdNU9vpxUkttXXx8+VOJaZX9b0S0yE6isAEzXUS5yNgw==
X-Received: by 2002:a17:90b:2f06:b0:33b:bed8:891e with SMTP id 98e67ed59e1d1-3408307ececmr15049100a91.19.1762171656813;
        Mon, 03 Nov 2025 04:07:36 -0800 (PST)
Received: from E07P150077.ecarx.com.cn ([103.52.189.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9887a3f044sm6329497a12.18.2025.11.03.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:07:36 -0800 (PST)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH v4] libbpf: update the comment to remove the reference to the deprecated interface bpf_program__load().
Date: Mon,  3 Nov 2025 20:07:27 +0800
Message-Id: <20251103120727.145965-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit be2f2d1680df ("libbpf: Deprecate bpf_program__load() API") marked
bpf_program__load() as deprecated starting with libbpf v0.6. And later
in commit 146bf811f5ac ("libbpf: remove most other deprecated high-level
APIs") actually removed the bpf_program__load() implementation and
related old high-level APIs.

This patch update the comment in bpf_program__set_attach_target() to
remove the reference to the deprecated interface bpf_program__load().

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v3->v4:
Try to fix the CI FAILURE issue by rebasing the local code to the latest
version. The v3 version is here:

https://lore.kernel.org/lkml/20251030060322.1192839-1-jianyungao89@gmail.com/

 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fbe74686c97d..27a07782bd72 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13858,8 +13858,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		return libbpf_err(-EINVAL);
 
 	if (attach_prog_fd && !attach_func_name) {
-		/* remember attach_prog_fd and let bpf_program__load() find
-		 * BTF ID during the program load
+		/* Store attach_prog_fd. The BTF ID will be resolved later during
+		 * the normal object/program load phase.
 		 */
 		prog->attach_prog_fd = attach_prog_fd;
 		return 0;
-- 
2.34.1


