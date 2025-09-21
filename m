Return-Path: <linux-kernel+bounces-826315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1C7B8E2B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743B9175EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62DF274B31;
	Sun, 21 Sep 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA+Cbv4R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289ED258EF9;
	Sun, 21 Sep 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758477468; cv=none; b=aMAK5qvaxpq8DBpaU53tyzkRbZ0+GEdw9jhnTljGt7XlDJ/YsQR1ME+zs2QNVFPyn5N62zgxblTSgvJV/PjNNCFsG8SuyiYhxTenilfo+XzIZQJsPZCtKemdgfMRYo2xxrG0WKEH8QJaw32Kc+5OLu+ojmWgyfBu6z0Xs+1nCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758477468; c=relaxed/simple;
	bh=HPOXu+TlJzMdLNn5cD2aKzXAjPg9avReB9Xaamvv9Sk=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=DbKMAr8zBMMsscYJFimunMS8BSfkFcObA1en4jDqerIbb8gvmikWpcxpDYU8MpHL5jHgr9kcFdertP8b76w4/zij8234nFF9Nfrecj6F3+ERu0hoSBVBYe8XZ1KYNIW0RQzbKhti7GAlb4uupwT9+eEtCYPSRx/MoX/bZ4iu9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA+Cbv4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D50C4CEE7;
	Sun, 21 Sep 2025 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758477467;
	bh=HPOXu+TlJzMdLNn5cD2aKzXAjPg9avReB9Xaamvv9Sk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JA+Cbv4RaEp136fk39WwynfzX+FSGa7y5T+vthFPQY785pemI8EHmW+j4BDNNrriA
	 8RKNKyTXNpxmnsR5khRRnnK6QzurwvW/AzzTkKdtSFPKrk+YqZw3i+c4jZzf7L6udZ
	 QWXrfLdRjBsREjN9z+DMY+WrNieThvtVEVptMOGpgrmEwE7t7X/oKaIK7ScpzDDJGO
	 c3Yb2Z7vBctT4K0aIWAFQ3dxLLCQw8ASDFkjG/vAOA/89pRp/ygjRPNXS7dxN1Yt7Z
	 mjKy5oon/iq/wIulM02f/icFSr2JuzTucVPmcJSUQ/2jgSqlF5+0QQdzQu7MMBdx/1
	 2Kivv9vba8POg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250905091002.28203-1-shubhrajyoti.datta@amd.com>
References: <20250905091002.28203-1-shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH] clk: clocking-wizard: Fix output clock register offset for Versal platforms
From: Stephen Boyd <sboyd@kernel.org>
Cc: git@amd.com, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 21 Sep 2025 10:57:46 -0700
Message-ID: <175847746634.4354.18106399559947423215@lazor>
User-Agent: alot/0.11

Quoting Shubhrajyoti Datta (2025-09-05 02:10:02)
> The output clock register offset used in clk_wzrd_register_output_clocks
> was incorrectly referencing 0x3C instead of 0x38, which caused
> misconfiguration of output dividers on Versal platforms.
>=20
> Correcting the off-by-one error ensures proper configuration of output
> clocks.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---

Applied to clk-next

