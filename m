Return-Path: <linux-kernel+bounces-856202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A6BE3761
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C04B50155A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378032D454;
	Thu, 16 Oct 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ5pVDv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D121F330D31;
	Thu, 16 Oct 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618528; cv=none; b=DLmKTRAhgUWpj6beO+XVUOoDD4YtTLDhs4DUoN9xEwm1HCBRDfgqM4fFeCXG/q4LRFbEmNqjUed+/5h9xGTmEaAtSfRfyTvcegRhKbJNHWc2mh00TmUzn0qdQISqmik6GRgX1a6VQDBwByQ0XTTbAwcFnfgnc4rFCzsYg02c0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618528; c=relaxed/simple;
	bh=xj+tsH/YccpTlaki/CONlYf4V9pg/jEYqvRtkEjpKkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IXgfZK7Bb3WtiHH3bzks0vznsIHjTGzejAJpD7sgKDfXR6fvT7UXLmpfcJa7r1nj6xUFIHUiaUVeZGUVCpb0pw10B5hwYGlt4MIay2AphagGzHw0sASj4FOhdhmZr5GDbVL6c8SIo4ielO6fv+oJhHIqqHTcl+poPlhdlMdT/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ5pVDv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F185C4CEFE;
	Thu, 16 Oct 2025 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618524;
	bh=xj+tsH/YccpTlaki/CONlYf4V9pg/jEYqvRtkEjpKkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HJ5pVDv3ao6HbuJZZ88Na84GpEhRy4Yn1wWniL1z2GZ7G4Fsr2Taf3nfAgkZc2rdH
	 DkPK1mcHWZ/ShnKT+sIjnLLbj3loMYIxZWN81OBO0InnQl6JOZ7bN6b4XI88Xx5bz0
	 HHx/ZLXkl9L5YHOVhgJ8ovYgIgH7UxEJ7O4VPVHZVZld/UW+TYClmojrfWN26d5Ju8
	 2pdGo9Yhc03WB3/ofgZFiMCM0UpnrhAzpZ1eu19Y18SNvfTtfBphESxBpYkbBxoikA
	 1E0V4jHfU4F219h6fhYd/H52llHS+RgDP08MVy33GEF+sWoYhLXDaZ26BpClBsw5vn
	 K8d4HZcl0tnvQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Li Qiang <liqiang01@kylinos.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251015075530.146851-1-liqiang01@kylinos.cn>
References: <20251015075530.146851-1-liqiang01@kylinos.cn>
Subject: Re: [PATCH] ASoC: amd/sdw_utils: avoid NULL deref when
 devm_kasprintf() fails
Message-Id: <176061852278.55339.14706460406632258362.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 13:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Wed, 15 Oct 2025 15:55:30 +0800, Li Qiang wrote:
> devm_kasprintf() may return NULL on memory allocation failure,
> but the debug message prints cpus->dai_name before checking it.
> Move the dev_dbg() call after the NULL check to prevent potential
> NULL pointer dereference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd/sdw_utils: avoid NULL deref when devm_kasprintf() fails
      commit: 5726b68473f7153a7f6294185e5998b7e2a230a2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


