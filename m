Return-Path: <linux-kernel+bounces-805533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F997B489D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03E43B4A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D32E5B11;
	Mon,  8 Sep 2025 10:16:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963737081E;
	Mon,  8 Sep 2025 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326563; cv=none; b=WYGyRcO16R88PsY/RTfa2EBh2KkBJrsJGbpd2A9mWJdGjGS0nrSo//1OBmMHHkcvO2WDIwb2nr5ovpah6d82aashqy03pz1veXLOHTi9jNN7BKTyYaze09CV7qzlwqikVOSQel2dVPEjqY85VvKGMnWsI2pNYR6u+uwScV2pzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326563; c=relaxed/simple;
	bh=I6CCdO2I8OfTKvg8UkxnpsuGGSkgbMN9yxQpOATLnbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2PyzEcMzBmxmWSXoIIDt1Kh627eQ439t8NKvNZhzQvMfkohh1Cqw7zx3XvxawRDQOTs7wA3zWvYbl6EZdoYblSki2Y+5u1kr9BbDIN7O0orTNhupr3maw2UxBN9TLUFf5GF3hS4P7uNLuc5e/nyTLnmJHpZvOjtli2uNQcmuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E621692;
	Mon,  8 Sep 2025 03:15:52 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EE433F66E;
	Mon,  8 Sep 2025 03:15:59 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix typo for scmi_perf_proto_ops
Date: Mon,  8 Sep 2025 11:15:56 +0100
Message-Id: <175732651445.3916791.4020244491858368527.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250831-scmi-cpufreq-v1-1-493031cf6e9b@nxp.com>
References: <20250831-scmi-cpufreq-v1-1-493031cf6e9b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 31 Aug 2025 14:52:37 +0800, Peng Fan wrote:
> The name is power_scale_get, not power_scale_mw_get, correct it.
>

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Fix typo for scmi_perf_proto_ops
      https://git.kernel.org/sudeep.holla/c/72ca981dba5e
--
Regards,
Sudeep


