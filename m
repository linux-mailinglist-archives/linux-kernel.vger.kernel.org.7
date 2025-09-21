Return-Path: <linux-kernel+bounces-826291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B6FB8E19A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AB13BEF26
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B432262FE7;
	Sun, 21 Sep 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyjmj1GL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7C45948;
	Sun, 21 Sep 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475207; cv=none; b=HFsJYoE+iyld6DRi79lp5PVCtDH2N1oqItOwauqY51T08xQUxEbXWLDUetnESyX4kJki9ACgsHJgnRmpbiIaWgMxHb2rzqm6SA473sfsf20VxOP+4KSEeud4v3UX/i3nGbpy8tKqOlOpbqmiJsfwgwGr6J9DnQ+lHBlYa5pAx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475207; c=relaxed/simple;
	bh=nZFmlP/P0juGPtOeZk5oTehlfMx9ii7tpf1fA/FVz1s=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=j1woMN1gmyItlQzlMvsLvlCF2FTzV+JxkMNROVTQDpO19g7YckgM0+EsR7f75IKb0idxZJqg4w6r28Kqx7qarXsF64woHPuu3cierN/LFntA2VVES5ZMMb8D5kCZ0PMGrx3eTdyEC7fbKw6fZcu/F6XSV3+RBtEdg+YnuEp7d+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyjmj1GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DFAC4CEE7;
	Sun, 21 Sep 2025 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758475206;
	bh=nZFmlP/P0juGPtOeZk5oTehlfMx9ii7tpf1fA/FVz1s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Lyjmj1GLsZgcmTM/xErQpkAWiJsfqG74gTDr58NQ3iRoeTaRrrJm3x1fqe5xyzp4s
	 7uCBE1j4SHEYaWLo2nnhMFvuDKfEFWr/vGAL/wOeFA63LqBy6rO/HDNc0Y8vrTXuK9
	 eGcHTReOSVkA0DqwkFeEm8am/HXXAyY6OvdBcV/7xSPBeAux9q2fN/EndSWhICrp5N
	 Oa8xXMiWFxYE0tXINsU8Fsi4brW/QEcc/fA33rkfD9D9PIe1GW3yyjQsh0epUySM5x
	 yhPWSL8OwAUEgVHdK+q59NgKowEoFIyWNwYo6M0Mr36LdUD74DAgvQVpf/oFdSqPBg
	 Cva0Y3s7JvAlg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250814035317.4112336-2-wenst@chromium.org>
References: <20250814035317.4112336-1-wenst@chromium.org> <20250814035317.4112336-2-wenst@chromium.org>
Subject: Re: [PATCH v2 2/2] clk: Use hashtable for global clk lookups
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Chen-Yu Tsai <wenst@chromium.org>
Date: Sun, 21 Sep 2025 10:20:04 -0700
Message-ID: <175847520494.4354.5422042536281886650@lazor>
User-Agent: alot/0.11

Quoting Chen-Yu Tsai (2025-08-13 20:53:16)
> A clk lookup using clk_core_lookup() is currently somewhat expensive
> since it has to walk the whole clk tree to find a match. This is
> extremely bad in the clk_core_init() function where it is used to look
> for clk name conflicts, which is always the worst case of walking the
> whole tree. Moreover, the number of clks checked increases as more
> clks are registered, causing each subsequent clk registration becoming
> slower.
>=20
> Add a hashtable for doing clk lookups to replace the tree walk method.
> On arm64 this increases kernel memory usage by 4 KB for the hashtable,
> and 16 bytes (2 pointers) for |struct hlist_node| in each clk. On a
> platform with around 800 clks, this reduces the time spent in
> clk_core_lookup() significantly:
>=20
>           |      PID 0      |     kworker     |
>           | before |  after | before |  after |
>     -------------------------------------------

Applied to clk-next

Can you send a followup that adds a unit test for clk_core_lookup()? We
don't want __clk_lookup() to continue being used, so maybe we can add a
test only exported function like clk_hw_lookup() that uses
clk_core_lookup() underneath while grabbing the prepare lock. It can
make sure a registered clk_hw is found and a non-registered name isn't
found and assert that the not yet registered name isn't found.

