Return-Path: <linux-kernel+bounces-763635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933FAB217F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9CE462E58
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192912DCF5A;
	Mon, 11 Aug 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cKYStbuG"
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7122D63E5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950309; cv=none; b=IOLXlZkZlH9fUZFCL4gw+BXsO8bhDALPSsFh2yPhrKwk9hZDoEvEaXLZoPHIADZs+xKSFvPw82dic2F70Rb06c9dwBaUSGMiXFBTn6eqC19dfAQvjCLjA9RThkNxbmzsJZsEN0iH3WK/d083lSzgq9AGRmXSWaYjLVOlsLw+RO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950309; c=relaxed/simple;
	bh=rD1oz+oWneUwDlPy8t5jpf+s4P4nPMQFdqEZjAHFxoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qUfzyBOqiI/tBcoFathczVMeTp0+VkGQT0UiraUKamJjgMS2KwM3ajhSLK+WFMQwzpuuKHME6NgLzacguTeOXNaU3RojJgDh+7++rWgRymy5ykaViYr9J4Au2+Gn9Q0qUtdRCCZrUTUdQB0w8DSi6VaSGFvvZRRHjSkj6MzOtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cKYStbuG; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BLOZ1a024646
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=pEFEFVE08AQwC9Il4xDKhb0NEA
	k5kZk2zpQmERpJ5cA=; b=cKYStbuGk9wa8cU3NnDlrkZ5oJTh+h34YCx8bK5jnO
	dl38XqvIDMWrDJBn1w3Kkv/6uJ6udg8Ee0ZRcluFIcThEDzAzeCK8RPgywYaWbVg
	mjfRyMXR1A8tEm6uYhYbp3kz5uV/bUWN2LbdcmIeQUt7TNu2CSaul2nIHoyDZOGp
	Vsc7amTYXXtu6oTqeNcdo4P/MQK+p11Gew73ihZhK89CwLHlp1tLwNDGITdP9Q+p
	1u528zLl/hMaNci4x6xrZUReq8tFTVW0p4dLBih7lNGF3eOe6JQFi85xixyELREX
	Nc9LPQeH0yED+bwnDXA/oydcAjtpBXKmA6b/+LrCCgcA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 48ejwk2wsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:42:16 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af199d0facso149639041cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754948535; x=1755553335;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEFEFVE08AQwC9Il4xDKhb0NEAk5kZk2zpQmERpJ5cA=;
        b=sezkkoCV3LHHg+Aarrxs8JjiFMUm9B3Pwrgzl4XYS3te93mue9vH4ZiTruIlEWlUXC
         3Z7FWWf8BcwgWgWxSI33HuBxBY/VtU4oSucWqIpa8GJRLGMYLPwFxsIER5KwoKmVHb3M
         zOGB3AZPpSHpIzhyoN8GU/igVu4oSj5i9yNfBkqp+hzwnrYO2utgZ6T7yK+QGhTkSE+r
         BJXltwY7drFaeOV0qyBmSmIs1Wvx6vW862E5FReQ3IOrzVZKG7nZ7IFgmSdShE5g1Efj
         mJ5Q1LhvRvOhJi2PFuyrBd90M6YeaxnSO4WUp3bDeUiypkV37B10lwwDJpGya6TZ0fDD
         L/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoDTacAvUkS5iugOlL4xFlqityEFld5NCeVnt4g5xxhCrANnZsUXRd0Hc/YiArypxze6JP/y78wjJUHvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8A8b6fTovbdEjGEe7Mr/FjfpxDYF4Lr5vyzGbwJK0mCEngdz
	c2uJ334M034mwChxG3YEohv4QicY3qBOLDBZIXNQQtCAvICKbzf7n0et6+pfmx/Apg7kcreyy5g
	qxgnu6PDjvZNqBCDYlv0CB/BfQkSkZUtUyRFWQN5AG8aMb0ztOkS3rf77b9Z0dA==
X-Gm-Gg: ASbGncsQ0BreoJOdSgNg2/ucMs57VW7suXXBJv8pv6BnjyE4a8yHseNMTFUynbh6QHw
	kQlIo8S7alrbZaZLLhR1kneWPwJuXm1BAFz9PB5SttVnafWWPTsh48dGyymmb7en/NNyj2rHyiC
	6i9YaH5TpS7Jgime4UZkQFP/tay+dHvgXxVoXIpcpzSO7dUzxvo276A+Gh547hFNBd0Wqm2Kc63
	Fusl5JWGItRhG6Mihdnjt6UV4hmKuuHqWDSelOo6rBzcpFhswbSFeEt/elzXM/kdrFLkR39RgJF
	38hcJJqzPnsnosu88sOPfIf6XJLtrwyk3qq5m2KebfkXpHx2Ztu9ZktnssgQqzNN09EoXrso3rI
	Yvf30DCD/zg==
X-Received: by 2002:a05:622a:1a25:b0:4af:1fd3:4eca with SMTP id d75a77b69052e-4b0eca8cb6dmr15270891cf.25.1754948534746;
        Mon, 11 Aug 2025 14:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU1AoXh09loZLwU+33OklQYn/p/cwiFAD8eoDZ99ilW/Vtx1hYeKfFQbsgYX7pcVmzGOMVJw==
X-Received: by 2002:a05:622a:1a25:b0:4af:1fd3:4eca with SMTP id d75a77b69052e-4b0eca8cb6dmr15270501cf.25.1754948534141;
        Mon, 11 Aug 2025 14:42:14 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-183-206-55.red.bezeqint.net. [79.183.206.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583f9fcsm263940065e9.4.2025.08.11.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:42:13 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 11 Aug 2025 17:42:00 -0400
Subject: [PATCH] vboxsf: Convert vboxsf_write_end() to use
 kmap_local_folio()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAKdjmmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ND3bKk/IritPi0/JzMfF1jE+NE8+QUy1TLJCMloJaCotS0zAqwcdG
 xtbUA+D1tQl4AAAA=
X-Change-ID: 20250811-vboxsf_folio-343a7cd9e9b2
To: Hans de Goede <hansg@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754948532; l=1044;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=rD1oz+oWneUwDlPy8t5jpf+s4P4nPMQFdqEZjAHFxoA=;
 b=oKspY0LE9uo50vutKmomfJ26S118Lvnuhh/I7EdTPFy54kleOmD2HHfdmp8nruHQi2NnR3xIX
 UWtkoEx3wVABpvozIV8ou9q7W9u2PC56HyA2ZpIAQABJ1vK7YC+uFkj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: ZJF0L3fYQwIWW80jS6dAPQXdIMX0pj2u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE1MyBTYWx0ZWRfX855W+eEDJvID
 XeYAxdf2ZmNiikT/vavXdhJOnosHZBXLaBKolM3nxRO9JEcqeOiBienqp4vMoXnTQj3yKb+PawK
 Hr0g8ZPB4s6qvDkaU6GkZZ3xwjJw8gPsWKscX6r/AjXQt0aRP+e0dkp+pNWqSWLxdHuDy28gOZt
 PHA0GE2pJQqKSklN/Hcqr9nXw6AJbu/UF2I7F1gEQcW8a4E52tdqRYAxywSGrzQ0pnYWA9NaGZW
 8SStQUuj7HZ4T/RvBionbC5fISrVt7/cqDtwaftm58txtWoJAmK1Ce8tRfUyWliwRIl7/8l/4k6
 qo0tdM2l6fh0p4ccMcqXcQ+car+ral8J97XBUHj3jEYMLc+mAFwj5A1vtRHSqvuW4zX0/brna5E
 8F7wLb0Y
X-Proofpoint-GUID: ZJF0L3fYQwIWW80jS6dAPQXdIMX0pj2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 bulkscore=10 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=768 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110153

Now that vboxsf_write_end() takes a folio, convert the kmap() call to
kmap_local_folio(). This removes two instances of &folio->page as
well.

Compile-tested only.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/vboxsf/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 4bebd947314a..178fc74e399f 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -316,10 +316,10 @@ static int vboxsf_write_end(const struct kiocb *iocb,
 	if (!folio_test_uptodate(folio) && copied < len)
 		folio_zero_range(folio, from + copied, len - copied);
 
-	buf = kmap(&folio->page);
+	buf = kmap_local_folio(folio, 0);
 	err = vboxsf_write(sf_handle->root, sf_handle->handle,
 			   pos, &nwritten, buf + from);
-	kunmap(&folio->page);
+	kunmap_local(buf);
 
 	if (err) {
 		nwritten = 0;

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-vboxsf_folio-343a7cd9e9b2

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


