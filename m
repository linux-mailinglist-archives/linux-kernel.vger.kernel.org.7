Return-Path: <linux-kernel+bounces-790401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF165B3A692
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8624E18920ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31F3314C1;
	Thu, 28 Aug 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxKuNtwQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF8322C89;
	Thu, 28 Aug 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398930; cv=none; b=JE7vnfjwdiPnh7GWTo2kbBv7xstFaemhrauTVndF13D5miIy2FBraW3uPpdBtW+dPD7MVyxNi3BTiETb8YzxsxYJKICVM2C5lqVUUaIFyhXweajd7N1qPKGVtECY+HgzwIF7QePDZDhsFr2x8BIUKDmlP/lsNyVPoo1mfplnq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398930; c=relaxed/simple;
	bh=u/YoKxRzlJtVqSxZvRdsOO8F4FWrrfLyCosH+wkjmbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HohVc+Q421dPXRrk+sDznCx+C0sWBUeXQykPau787Nps0nwa5TjTWxk1KooSno+v8Lb5Wen4Muxhk3tM9zE9hMkNMvhFLpOZhvzCeFqoRyXc3wP/zYVMe8t79Eka5tFJty/dtqMfRx3p6LPsQjgGFfVTZmnzVf+5f5Hd9clpgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxKuNtwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CD2C4CEEB;
	Thu, 28 Aug 2025 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756398929;
	bh=u/YoKxRzlJtVqSxZvRdsOO8F4FWrrfLyCosH+wkjmbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxKuNtwQlpEupBZf+uzSpFmxGro1bKVymgEm/RNGjj7tGAPsN1SBu2Shv0DTYuVpF
	 vplQtAYpSSns+bx89QmkoNlpj3BnTuY9l6jK7irBaViXxUrFwnPnmFob1k3HfBsVg2
	 Rf+YUIrZXgHLU9bg2VnKpQm9b1NN/YCZUIjeyoxY9ZKJ7P329od5z0wtSp9g3ZLURe
	 utGcGyswOLY8HQKF8pAaxIY9OoVtBdKaZycJyFZso3ALcVr9GTliROsmMUu4uI7jL0
	 BdsVnwFcqvYh5h6EobnklPjvnMdsPtTQpAzo9XfHOioKb+QTbyC2CN/+D4gcA/jUcr
	 YFwQmr7indN2w==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: cache: ax45mp: add 2048 as a supported cache-sets value
Date: Thu, 28 Aug 2025 17:35:20 +0100
Message-ID: <20250828-payback-suggest-f1cf62b3f051@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827-negligee-kinship-7832ba58deba@spud>
References: <20250827-negligee-kinship-7832ba58deba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=500; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=JX3w7EgTTKDSnT97jv6N1X/YhkPDkl/o1BzRKrboV24=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBkbWr0kHh/Y5XJ9o5bZWqNmxUPGof/2G7MvUrXq21XBb 69RbLmyo5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNRkGRkWPhPV+DxPzveF1rl S+Ti8l5u+2BYHnRW9ML+Limbpv1yjYwMxzJNdJuPxsrZH2S76OfELnapN2b9Ws2matYQKf+dXyY zAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 27 Aug 2025 19:03:44 +0100, Conor Dooley wrote:
> The QiLai implementation of this cache controller uses a cache-sets of
> 2048, and mandates it in an if/else block - but the definition of the
> property only permits 1024. Add 2048 as an option, and deny its use
> outside of the QiLai.
> 
> 

Applied to riscv-cache-for-next, thanks!

[1/1] dt-bindings: cache: ax45mp: add 2048 as a supported cache-sets value
      https://git.kernel.org/conor/c/4fab69dd1fa5

Thanks,
Conor.

