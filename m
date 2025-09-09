Return-Path: <linux-kernel+bounces-806981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E8B49E76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A732C3AB0B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E321FF4A;
	Tue,  9 Sep 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk2HB/ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9921C9E5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379715; cv=none; b=HBsX0LiGaSAQoV67zCx5Ri3gByhzr4KoolWENdq5LwWUf6k4ODt6AlHu5Lk5NMi8NGRuwmutg95u8GrmzLD0FMyusAOcLmXkaiCAHj7KQrWtNnPusgUEwYSS4sVRD5mDZ0xX4gFa+vmtHumiQubiKJ8sm9ePf1n8LbAMt35OB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379715; c=relaxed/simple;
	bh=jk9o4KGOZ/CqEAdi6n2rbEl/LNSY7ucNQJZqEdxSR3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jk9SC63kgMUjpPwcXHk37aPO8qkj6rpQ7ZfwaV5pOGT+YKyHgzZEhgkpyLBD08p2d4KZE2eLx3OG25AbLMdF0OlDHLsjhrSqTjrmXQ0mHh2201a5kfqbZ391FMCDdYjIBqzyppBNYXOpM6XmzfpFt2OQMJd16mweFhvQXiWikQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk2HB/ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAB1C4CEF1;
	Tue,  9 Sep 2025 01:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757379714;
	bh=jk9o4KGOZ/CqEAdi6n2rbEl/LNSY7ucNQJZqEdxSR3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pk2HB/mlUv63og6M8TymI0CD2funNF+uMrzox28tM7teDA+edY3bSvgM6FChOB8Zc
	 MOjN1cTZgUB0u2zALxRpfgI0l+0p/O0ZosqkuVbjrz324wKFDoBX6qb2NAtG7voBlr
	 CU/3P13S6qtIks+B4HETvd0RJtCyKPOWnqjkCuoZwWKE1nadZebxNr8tPBcAdStYah
	 4wbV1MY00hFNl4ZWQnnVUbgYog2DFUY/6SzqzRB673EiPI1ykTZA3Fn+AbvHeRMfaQ
	 uSzmNN9Z1lslYngseS4JLRHJ7gI93xrp1PqWPu/mYw5l/aGB1cbTts9czHtYlo3lvc
	 naA+0kxahA6SA==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Jann Horn as rmap reviewer
Date: Mon,  8 Sep 2025 18:01:52 -0700
Message-Id: <20250909010152.63978-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908194959.820913-1-lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  8 Sep 2025 20:49:59 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Jann has been an excellent contributor in all areas of memory management,
> and has demonstrated great expertise in the reverse mapping.
> 
> It's therefore appropriate for him to become a reviewer.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

