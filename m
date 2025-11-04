Return-Path: <linux-kernel+bounces-883947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E2C2EE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5161886142
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1542C239E88;
	Tue,  4 Nov 2025 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI0fn9eX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF517D2;
	Tue,  4 Nov 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221287; cv=none; b=VTpYmve2i0GMwfp6IwusBN1Zyf5GO9s/JWRcVnNj2WKrC4C0KMW5d8/7iHmBrOYXS2gwun39eIaRpbKDfU34iops/rthJ4p9FsURTE9SMYgRoRLzndsx8W/kAg8LeduTc4CS9q6LLZkZ+P1j4Dy+tz8ESY8FBoBXweMDL3dRi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221287; c=relaxed/simple;
	bh=NIoqR50OtnZiIZ/gzbzwn7O2i0JuModw5X4+v8aWurA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fU5jpi0gRK0a8u/WSSXW9N4nHfCrSTg7SymPSqZk3tNeFOIaUJjLWbSfJv4Lbrcl2UR0LUa41VgUN3HhOksQzsSfaiX3BPSQtCjM0XubrfFpgstbFj7tWN7L6TV5t/XDcr5MLs+Xga1rZHj9jXbxmFEoNpqAbgz8k1jtN0Gt7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI0fn9eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B01C4CEFD;
	Tue,  4 Nov 2025 01:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762221287;
	bh=NIoqR50OtnZiIZ/gzbzwn7O2i0JuModw5X4+v8aWurA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MI0fn9eXaq1hrwOgxOYdj2EP9GEn83yw+Uyg2Qbu69zUzAh6X40CaujGzxff93EYI
	 Eo4pWUJXU5JUYg1/v8vWfqKWW00Eu8gtlJ/vVqtU4O0EsixMYEWWa8lvombm3W+EjB
	 g7kdnNNKkaTHf1faEQqLIqNfAJyncfAeFTrKbS3dSgiUZs9qBjQd7m5YvswhjvufAM
	 bshVEZ5jrY+mqQlNJRnWoqv3BwnDjKVA14yZkcvUkx7s9p2en5xaoVZ7rPUgYOZh9w
	 IqOSin/v4ZuwqU6cFKRiUvXEOAvW1nAwfZJ4z5UaBS8Y9SYlRg4Q4pf/I8UJKPdXK8
	 MfJrL/fld+LLg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Rename vph-pwr regulator node
Date: Mon,  3 Nov 2025 19:58:13 -0600
Message-ID: <176222149537.1132260.8094838309369339236.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102-rb3gen2-regulator-sort-v1-1-908879d240be@oss.qualcomm.com>
References: <20251102-rb3gen2-regulator-sort-v1-1-908879d240be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Nov 2025 11:22:20 -0600, Bjorn Andersson wrote:
> When fixed regulators are not named with "regulator-" prefix, they can
> not be neatly grouped and sorted together.
> 
> Rename the vph-pwr-regulator, to facilitate the incoming addition of
> additional fixed regulators.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qcs6490-rb3gen2: Rename vph-pwr regulator node
      commit: 72a63169bf1100a64affde275ba90d7607f872c6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

