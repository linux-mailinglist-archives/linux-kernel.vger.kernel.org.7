Return-Path: <linux-kernel+bounces-889558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05610C3DE71
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F133AE6B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342FE3557E4;
	Thu,  6 Nov 2025 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9Cy1ioi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39D305977;
	Thu,  6 Nov 2025 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473264; cv=none; b=bJo8QvBUdSvCepFUc3HhYpls/ibDDETfNp6TUvPLT7dlW2ID4dQP3K9SX2+jytTlsBH3rSGo/++G27ZfZnJtEFaqRo18wu/n0uyF2JCWFHsPvP9Mr0nG8Z9A13Nnha1uzwzknsDbOYmqcQZ6NXauTScC3zk8wVUAynMkCWMxh0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473264; c=relaxed/simple;
	bh=nUgrKOEntcoxnLMXZVxWwUI9CbwzMYPoAkwMzotuOOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iRdd7MHNywu5tYh62XwNP5hAKSy8M4e63oYo7PvT4C3KqVNwH3OGvLEGcU8DH843V6uqrYaTKBsoGi1F/fePmwbb8xjZvVay1lFGqtDhgM2NAkvjIXOmoln0JXyeDtFt4KWGGxsQuFYwji+gwr4uxc/QLrUR7zz/E4N+9h98KWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9Cy1ioi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E79C116C6;
	Thu,  6 Nov 2025 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473264;
	bh=nUgrKOEntcoxnLMXZVxWwUI9CbwzMYPoAkwMzotuOOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e9Cy1ioiBgg2IZziJsSnPM2e3+VSkoYpu53IVyPpk/ZevsKAMfAKMy/vnAV7iMFvq
	 zcJDzTr2Rrwb7/f7W5S4Tzgkil55/uSPYDuUtqONeK6kI+jvBl8LLq43BFFBVHdmLL
	 s/F1uLxE6o0gWJigWC7O0BO8o+/BDngSKtp0WI+jCozdVMlK8cJJOtk5jhmTqwt4eh
	 8JK5XpeQPd/aVEUtOGtxvU+j/PfpoZI6FtTgs2K/HUR+vVgKxz+ykI7KTJkpxa8H9a
	 x4VKQs0EwF0Nx/j7jnIRHbLWq682w0lLFnMKLs9CZdZbVmy79Nv12n/X59uLkJNZMs
	 Pgh+mvfTehB8w==
From: Mark Brown <broonie@kernel.org>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 wenst@chromium.org, igor.belwon@mentallysanemainliners.org
In-Reply-To: <20251027110527.21002-1-angelogioacchino.delregno@collabora.com>
References: <20251027110527.21002-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH v11 0/9] Add support MT6316/6363/MT6373 PMICs
 regulators and MFD
Message-Id: <176247325942.2483095.1363987867451171276.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 23:54:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 27 Oct 2025 12:05:18 +0100, AngeloGioacchino Del Regno wrote:
> Changes in v11:
>  - Removed unnecessary #address-cells in all mt6316 bindings
> 
> Changes in v10:
>  - Added "struct" prefix to structs kerneldoc
>  - Renamed struct mtk_spmi_pmic_pdata to mtk_spmi_pmic_variant
>  - Added "REG_" to MT6363/73 mfd register definitions to disambiguate
>  - Expanded MTK_SPMI_PMIC_IRQ_GROUP macro parameter names as suggested
>  - Some rewording of comments as suggested, addition of more comments
>  - Refactored IRQ domain handling due to deprecation of function
>    irq_domain_add_tree() to use the new irq_domain_create_tree()
>  - Fixed to use generic_handle_domain_irq_safe() to avoid races
>  - Added support for two interrupt cells in translation
>  - Removed .irq_lock() and .irq_unlock() in favor of lockdep classes
>  - Added support for handling PMICs without IRQ Group register for
>    upcoming MT6685 implementation
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/9] dt-bindings: regulator: Document MediaTek MT6316 PMIC Regulators
      commit: 40a7c5db9020079547358f486ef12d57c1a7aa1f
[2/9] regulator: Add support for MediaTek MT6316 SPMI PMIC Regulators
      commit: a87a7b3530728fb7477a74c27fc27e060bf5684f
[3/9] dt-bindings: regulator: Document MediaTek MT6363 PMIC Regulators
      commit: d0f9f5b7a3356b43f78b37b9cc3671ecc7469356
[4/9] regulator: Add support for MediaTek MT6363 SPMI PMIC Regulators
      commit: 3c36965df80801344850388592e95033eceea05b

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


