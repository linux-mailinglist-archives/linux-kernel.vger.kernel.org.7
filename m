Return-Path: <linux-kernel+bounces-721885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6DAFCF1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4AB581984
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B790B2E2653;
	Tue,  8 Jul 2025 15:23:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE432E11B5;
	Tue,  8 Jul 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988206; cv=none; b=Z+uG6gEsG4MrTcpo5SrQM+c44wKiIOUc76kXxFWsTu1U3YFx+bGRv5mtsYrQPq55r9b2N+1MqyvFO+U7ptk9ONuwdFc4YsPdXTmjUzrgxARMo+529QZQHgcEzCIpKmzf5IdfWPs/MPacsxWb7vG4Xm7jCUgW+rlvsn+T1YcLRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988206; c=relaxed/simple;
	bh=nm1vOCJPrlUNk3kUpdwdQ5XPM0b1/0+Pfl3zP2AMFTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbTOZ+OSQXH4o0Pd8R7zbXtg5x+6Yt7D5Um01lyj9he+z/8+xotMjRALEyt5Hx+0En2rSAufIvWq5DKUA1F4o7bRBVj3Z19HYXIN+XFLcVTStVj7L+bbqWCoF/SfSRZmXfxKpyvZ437cI8gbqqHtzBaAb5T7jCyZnMi701kzHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0727B153B;
	Tue,  8 Jul 2025 08:23:12 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C45B3F738;
	Tue,  8 Jul 2025 08:23:22 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Philip Radford <philip.radford@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	cristian.marussi@arm.com,
	luke.parkin@arm.com
Subject: Re: [PATCH v2 0/3] firmware: arm_scmi: Add xfer inflight debug and trace
Date: Tue,  8 Jul 2025 16:23:16 +0100
Message-Id: <175198812770.785521.16973338281288215979.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630105544.531723-1-philip.radford@arm.com>
References: <20250630105544.531723-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 30 Jun 2025 10:55:40 +0000, Philip Radford wrote:
> This series adds a new counter to the Arm SCMI firmware driver to track
> the number of in-flight message transfers during debug and trace. This
> will be useful for examining behaviour under a large load with regards
> to concurrent messages being sent and received. As the counter only gives
> a live value, printing the value in trace allows logging of the in-flight
> xfers.
> 
> [...]

Applied to sudeep.holla/linux (for-linux-next), thanks!
(with some commit message changes)

[1/3] firmware: arm_scmi: Add debug decrement counter
      https://git.kernel.org/sudeep.holla/c/555e9174ef06
[2/3] firmware: arm_scmi: Add xfer_inflight counter
      https://git.kernel.org/sudeep.holla/c/a9cd861e61ae
[3/3] include: trace: Add inflight_xfer counter tracepoint
      https://git.kernel.org/sudeep.holla/c/f8e656382b4a
--
Regards,
Sudeep


