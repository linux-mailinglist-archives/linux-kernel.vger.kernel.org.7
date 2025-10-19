Return-Path: <linux-kernel+bounces-859656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FEBEE36B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFAB34E85FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A032E54A1;
	Sun, 19 Oct 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw9xESWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CD2D94A4;
	Sun, 19 Oct 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871214; cv=none; b=tVUVEdnq1ZuuJsM8PVLc0IOw5AE5h4GTGJEXdfg5ouJE+Hvc9VqFfSkuT8spEM4aXwiVGT3pzMcNU40Qnl4gtxwSkft0GJLiHaGVlAhsd4pL7hp8X5aK8QxeNYgkh4THao79IYNaWwo+9XZNKGoLxMNDLDl5XnybL72rbBb0i38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871214; c=relaxed/simple;
	bh=DIpyWgDHxamRdUXKHbbNEu45AREQVMTGhBtf03xL+m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LhkKjr8W5ZyyJ7GTULMxR/FYUTHOOkYGcfifLUWiwpx5J89JH27PQcICxXcLcQ6Y9VIE7O1PfNW+6pWwLUO0SxiNQa4LKQNSFvSXyHGrXwJ5zVeatj0+9JkRKC8ej1U72ruWnH/0w1Ai0w/jQoW6L6y3Dv2NaXgJmkWtWIQdyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw9xESWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E597C4CEE7;
	Sun, 19 Oct 2025 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760871214;
	bh=DIpyWgDHxamRdUXKHbbNEu45AREQVMTGhBtf03xL+m0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Aw9xESWQjbdQ72voqlu9rqrgxbPvbLcecrZMbCJCPOXy8dw9UkE83FuM8+kIYEbz/
	 E+CLAX9QcxpH7k0XZXwvGPEqBJU/y3KbD4A+yExT65dTCgFa1MlMxnDc7cdCJNzTPR
	 6YI5QD0wEoRkcTGQIrq3K7nQlxkKK3OQtbA2x6ziGuOAaJtaM4H7yoCx4dj20sykvV
	 XEDw62ScrQ4+6xETK00Je+OrPsnOQRj7MwyeB//rl/e0xbc/p1nK/JAqQw9Hy9Msu6
	 XC+FUN6BhIpvllx3L7LORZ30vLrkBx8/7IzMmouh6deGqy6L5G98+5IlUNFpcoD9il
	 AHCe05wKdxWxg==
From: Leon Romanovsky <leon@kernel.org>
To: bharat@chelsio.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250929091102.50384-1-alok.a.tiwari@oracle.com>
References: <20250929091102.50384-1-alok.a.tiwari@oracle.com>
Subject: Re: [PATCH rdma-next] RDMA/cxgb4: fix typo in write_pbl() debug
 message
Message-Id: <176087121096.148517.11307955840338942731.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 06:53:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-3ae27


On Mon, 29 Sep 2025 02:10:56 -0700, Alok Tiwari wrote:
> Correct the debug log format string from "pdb_addr" -> "pbl_addr"
> to match the actual variable name.
> 
> 

Applied, thanks!

[1/1] RDMA/cxgb4: fix typo in write_pbl() debug message
      https://git.kernel.org/rdma/rdma/c/cfd51fcf117157

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


