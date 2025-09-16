Return-Path: <linux-kernel+bounces-819314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB7B59E89
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD38B1C033A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40E393DFB;
	Tue, 16 Sep 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+lYnOgw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E537C107;
	Tue, 16 Sep 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041907; cv=none; b=KLekGf1qGX7Pw66Lezg2soi2eVhEV7n51RRgQ8NediMHuICoIVdlrx0aWpV9U5dYYLqvgr8wVyTiq6wSB6oBkJZ8An2p68NRzE1Xkh34JssvlbZXo0DFZ5VKwKOqFr+1MVyrngHZ10PMjGg461nPwNpeqdEgnzLNv2WH6zqVTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041907; c=relaxed/simple;
	bh=pfbgJjMr89WNcjYewyMcRrxcDhNZYVDR/5OIy8LsGDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRk8YjFSE41kLHDm7Ag3hN9XvI7HirKar6B2p2S4fSxOH8AfX9brLzn4HSbWcscmYSyeq3LtWATU5iKCSa5K6z/okHO0UgOB1VIt4HaCHojjsJXZwwMYtsT0uF8Wysu80LUh7CQMP2coJzE6YhCLrU5r4uADgbeP3HXPbxvfEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+lYnOgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809E8C4CEF9;
	Tue, 16 Sep 2025 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758041907;
	bh=pfbgJjMr89WNcjYewyMcRrxcDhNZYVDR/5OIy8LsGDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+lYnOgwwfjkKwqgYDOBriqAgG3hd/mR0ezv9+faSOpiYM93IcSGT2LAIrYYtNOLl
	 kee1T9u469GAaNmAqRKWmHMKCx+Fsjsbx9n31Jb0I16uyq24cwp/RqIyaYgwB02NWJ
	 o6yQXmyCK65sp4yiDivq2vR8H30C9ZCX7tpJsGHD6ICK1sV+tjOrYdqVKbCgYNQziP
	 r4ngCBjXW5Q2xQPygXqglPiD5PBaMYe78WDnaCKejYI0rS7pbksFTEq8uw7gx0iPs+
	 mbZUP8fUrm2dHWFdeGpOiPh9ny2ZirUhPuCD0Qq68lEAOK1r6bro+QWBSPv1vGjtel
	 RRZ9lsz+Wupgw==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v9 0/1] arm64: dts: qcom: add initial support for Samsung Galaxy S22
Date: Tue, 16 Sep 2025 11:58:10 -0500
Message-ID: <175804189852.3983789.6049695545221482528.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912202603.7312-1-ghatto404@gmail.com>
References: <20250912202603.7312-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Sep 2025 20:25:56 +0000, Eric Gonçalves wrote:
> Changes in v9:
> - Change 'vph-pwr-regulator' to 'regulator-vph-pwr'
> 
> Changes in v8:
> - Rebase on 'arm64: dts: qcom: sm8450: Flatten usb controller node'
> - Use real name for sign-offs
> - Remove device tree binding patch as it's already in the tree, merged by
>  Bjorn
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: add initial support for Samsung Galaxy S22
      commit: 11cf389c103f69d1170fbd70acbcc282cf03b748

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

