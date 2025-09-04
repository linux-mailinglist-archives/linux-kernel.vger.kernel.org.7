Return-Path: <linux-kernel+bounces-801079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D57B43F91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E887567F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E130499A;
	Thu,  4 Sep 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLxQlCa/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5978C301467
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997409; cv=none; b=Msa8Ic4E9NA2nEELUri1vFSh+xw6u1TgRsiwD90lsNLmqiRP2i8rhGY8KeVF7NB/5djxUWbs2ZaqL1Qv2YJmKaVvd1P8IImwQ05b/Tb7Q+AX0fe0tWIsXTdIs2uaow33pZWysiwv3l/88pOT2tnOUmG+2rDOfgosmvICxQFlq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997409; c=relaxed/simple;
	bh=3w/AwgiHvbPKnA4RDa/1jPdfETNhfrO+ka+RoY0zwaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ffv7kEbYfYoQ4CVxVPARS3Q6teWEBOjUCSrIgHtxxu07r3kzNykHzVdauxNaKh9fQIlZM1cBNO02hcDt8P/K5EAa+QrURBcOrr7TrIexv2Fq1AsLcVa8EPoPBBMfRm5/N4qaKRc3qwbMlVX+aj+UIl6GEfdqmiUvBwkeM2z+Ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLxQlCa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A551C4CEF1;
	Thu,  4 Sep 2025 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997409;
	bh=3w/AwgiHvbPKnA4RDa/1jPdfETNhfrO+ka+RoY0zwaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CLxQlCa/y2d24ExmxGy9GtPz78y8fZyR4+qRE0VgqOHjik1rjk8DRDgCjx/GCN/1S
	 TjyYq7xXb9DjLZxS6PtS1g3G2ALA3anR+xM66dpp1CFcMofrHH2/nho61usRyKUBSJ
	 M28obgXcNx2thNgnBpI8h4CXej2SfDrj797dswAfGg38jGohVy8SfbMyTazGV15Qcq
	 f3aeTAhsOP2dBgpa9rnmRswo39cDTMVdVMPcrTO+0TgyVnYdqY7sexeJoJlqJzDA/b
	 iMqvWh5b7aAH0eR7Gl0e/LgcbbhuPDtOgIbO9PqwW1pAEL4QGFmjxk+qxJ1dZoS3Bn
	 8xHSK7zjUwiWw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: leitao@debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812082709.49796-1-zhao.xichao@vivo.com>
References: <20250812082709.49796-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] configfs: use PTR_ERR_OR_ZERO() to simplify code
Message-Id: <175699739171.525565.12697545941903089219.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 16:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Tue, 12 Aug 2025 16:27:09 +0800, Xichao Zhao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> 

Applied, thanks!

[1/1] configfs: use PTR_ERR_OR_ZERO() to simplify code
      commit: 462272dd734b568f0190d01e24f5257c1a763fae

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



