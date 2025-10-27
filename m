Return-Path: <linux-kernel+bounces-871764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B82C0E47F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCD422886
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85D3074A4;
	Mon, 27 Oct 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFNOTO4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614E306B0C;
	Mon, 27 Oct 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573989; cv=none; b=l3cneCwI71eiItaRskGgbqo5AYVPxQEbXPDgZrAoehOGUDjXMR5N3ixDPCScSTMPhJta4Zj66IyKBsfH6qja1R6ahZfH5QuOka9zn2buuHXyMVxObeIDVx1FT+bUY5iRZdAlNVZc/0DBfy2UkxKOqOzfqcf3EnxHpKR2HvNCxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573989; c=relaxed/simple;
	bh=7GaZfmQNzHSeLbyvusv+384+vik9dzxAXunoBf510BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXIxIc/ldZgXNwmwR630FATSXMaJZzwuTcOQpj0tQsFqzTa/2XuHlgMcANGOIWe3SyeXvBitPSLpwhAgqOQbqkkvjfCHhVefx/a6Rqg1QIHhemJtSH6+iQ2XpNb2Z8BAqm4lQZ2wsrDORF0JznjGt22FgCBpn+tj0zYcadJRVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFNOTO4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DA5C116C6;
	Mon, 27 Oct 2025 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573989;
	bh=7GaZfmQNzHSeLbyvusv+384+vik9dzxAXunoBf510BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFNOTO4zEi7y8XOzN/NszC2rT7MBEHJPOni2eN3ap/1IW00jQRq9093dHBkNBJsiX
	 B1Eag7EW7BfLnXyspRssMbaBDxFxhTU0Bmv86iuctmg7i2AUzC/q5bB/Ay9v+Odi3G
	 glRXsfY91bvSPVMIjSBB1lCWBICpqmNLyFJwaVi5w28QcIt40ig2l5pXqppNdT5MmZ
	 1IP2Rp7lOvR3mcMRX5Dm2EFpjwBHC2RnUsGos+XZTJkqK5wEHoVXOIx+u39bYMA5Wz
	 jtm20YtourGIqW0XgG10P9la4O6dLGJgmF7mKDnFsggyQHccvg6BhqoA0VWoqk6CPb
	 CW6MeTjuJ5tnQ==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: pmic_glink: Add support for SOCCP remoteproc channels
Date: Mon, 27 Oct 2025 09:09:03 -0500
Message-ID: <176157405464.8818.5887965202916918883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com>
References: <20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 19 Sep 2025 10:50:25 -0700, Anjelique Melendez wrote:
> System On Chip Control Processor (SOCCP) is a subsystem that can have
> battery management firmware running on it to support Type-C/PD and
> battery charging. SOCCP does not have multiple PDs and hence PDR is not
> supported. So, if the subsystem comes up/down, rpmsg driver would be
> probed or removed. Use that for notifying clients of pmic_glink for
> PDR events.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink: Add support for SOCCP remoteproc channels
      commit: 6773cb33e7a7191ae7ae490af279596c91a828cc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

