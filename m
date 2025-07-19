Return-Path: <linux-kernel+bounces-737926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FF9B0B1FA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2979B17FD6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4021D581;
	Sat, 19 Jul 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eQBdRZBC"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C919F13F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752961581; cv=none; b=MYCuHmaF0FFkh63JgR94uzYyefgQJhM78rplW8aLWJT3XwGoxCrgNTNakw6PxWhLEQh9fprg2VhWjLnqherCQG8CTkcRVwhNsLSrzj7OqW+dOrpHyGoB8lTnV5+Ot1qXEBXoQ8ZQn9JUq1wu/kiEc7OWKWzGWRqZ3zhYzX1tRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752961581; c=relaxed/simple;
	bh=K7fmwbzAGB5SviPmGFl+B09mUOuJ9NRY2Punbj4PEfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux064ryeE8aMedtMApy4TWIveYA0DoBa+SeZXY8/ZO+fSckcCiA9SYtdhEkN446+ybKatQ5euJZcuRHYBU0ZY2VzOULRubd3p9pQ0w357dx3HaL2f+3C6HtKFT6eY1dDeXPiaSQi24y2J/N9PnSqifWSMXZsfrgemt4Hgu4M/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eQBdRZBC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-117-186.bstnma.fios.verizon.net [173.48.117.186])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56JLk1af009673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 17:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752961564; bh=exflGeeC4CnyyIBrcYnERcNj2c+ONgP0MDuvyGETvs8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=eQBdRZBCWYDQ6fdES3LPsxSp2HFiYmX15OSSgZ+SEzIZd8O01X2YnK74p7tOrB/Tk
	 SUJoH11MN/ldLAmq4f0AFpqLkxSzobcQ6JBuDZPSSlxaguZ/aiGp08dtOEFtVnjHPX
	 U9mh+qKUnOK01wiQlZ32Octf89IXktoNmFr3A+vsVYI5s5F0GwB9buDFI6m7qeBdjG
	 4bj78mndaWXKk04oj0Jce1j6nOwXifD39VfsB1Ys3aX2b9hkiC4fKSYHI0WVdJgu4b
	 adUakxEN4nJgX/pY2johgCftVaR4B8Pch8nulOijyzQ6G/xviigjxASegIU2ut6W0b
	 GwizKCrXTXjMg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 250E22E00D9; Sat, 19 Jul 2025 17:46:01 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ext4: Refactor breaking condition for xattr_find_entry()
Date: Sat, 19 Jul 2025 17:45:55 -0400
Message-ID: <175296153001.397842.9125557926811806145.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708020013.175728-1-richard120310@gmail.com>
References: <20250708020013.175728-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 08 Jul 2025 10:00:13 +0800, I Hsin Cheng wrote:
> Refactor the condition for breaking the loop within xattr_find_entry().
> Elimate the usage of "<=" and take condition shortcut when "!cmp" is
> true.
> 
> Originally, the condition was "(cmp <= 0 && (sorted || cmp == 0))", which
> means after it knows "cmp <= 0" is true, it has to check the value of
> "sorted" and "cmp". The checking of "cmp" here would be redundant since
> it has already checked it.
> 
> [...]

Applied, thanks!

[1/1] ext4: Refactor breaking condition for xattr_find_entry()
      commit: 9d9076238fe9fe45257f298bf51b35aa796cf0f1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

