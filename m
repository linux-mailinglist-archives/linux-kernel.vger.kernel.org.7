Return-Path: <linux-kernel+bounces-775556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509E5B2C094
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CCC1BA6496
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B978732BF38;
	Tue, 19 Aug 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6NdV2uC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5530F813
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603066; cv=none; b=a28kvH5R1/dgzCI7QEofqwLXNmEmDSb1dsgFuWvPWxDY8fi8NTdoZC5y9ZR7RYqjokIBTrLslWHB7JJbMOgKBtJujFfv4+ugVfJV1SeKTC+GwB7fe/08e0cElTzoAb49wSgICr1ppcsNRgXc6dT1Jft506Vd6UeY4Sy3Ta+uB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603066; c=relaxed/simple;
	bh=JqGTPRFLdezQhNuzmaMN2KEPrIgq8obAE1HHpynl8QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHa1dHFRC20tyIFBK/1eourUdfZj7Fsez6l4H9/1pyPPiOKypmqou4MkHi9H5nKDzrKc4UAdtC/VBrXXL3IdTquIEJb6InV6TbIg0ROQlMsxa8aFZ6iB6g9pdmW+H8EUAJzeflbMcuYvTwPxEM/zW5/CRcvN8sF7JjV2RVABSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6NdV2uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAD9C4CEF1;
	Tue, 19 Aug 2025 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603065;
	bh=JqGTPRFLdezQhNuzmaMN2KEPrIgq8obAE1HHpynl8QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6NdV2uCTxrIjaSfqV5quw/AGP9oOh5T2z4GAM3XjRr68swt3Ip5QDfdS2msp0U5D
	 W4mIeQObc356t5YKz9N+jk/EEc0zk9R29DDv1zawR49rJTdQUCuf54ItrC1BUMEOYi
	 MAn3lQ2FL6z1yDkl6WxCryrJ4bVwEgkOlJpFQSSmjF5RZSWe2q5VBsP5r/2lUbmZDq
	 7rGm5El84yv1zrU57ot2GOaMDaBEYYIOC5JHZvt4AIY71L9ElkNcnUqInUOB/Zr0j0
	 P4nrG69c2f6oXn5epfhPDMqZXJIlEBUHCOXBPrwvZ+1MGE6nmPGeqpHWGo+EOd8q2g
	 dUBDZFLOUuc3A==
From: Christian Brauner <brauner@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] minixfs: Verify inode mode when loading from disk
Date: Tue, 19 Aug 2025 13:30:57 +0200
Message-ID: <20250819-kochrezepte-rumlaufen-7e0d1e383b99@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <ec982681-84b8-4624-94fa-8af15b77cbd2@I-love.SAKURA.ne.jp>
References: <ec982681-84b8-4624-94fa-8af15b77cbd2@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=brauner@kernel.org; h=from:subject:message-id; bh=JqGTPRFLdezQhNuzmaMN2KEPrIgq8obAE1HHpynl8QE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsSSgp/9P5gUHD+Oq+KIkzyzfbrnT7XZuupDuv65Nu9 X7WJxd/dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk6BjDH55Gt5Ku9K21W0w8 lgvFHeb+P+nqqVizs1Ge37fY6MWzKDAyTLO7skUnQN+gi7N+55orNSllgQsmvp79U5GjNOTTDic jHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 00:17:44 +0900, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk can be invalid. Do like what
> commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
> does.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] minixfs: Verify inode mode when loading from disk
      https://git.kernel.org/vfs/vfs/c/73861970938a

