Return-Path: <linux-kernel+bounces-786467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470EB35A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA8A2A8577
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D527CB04;
	Tue, 26 Aug 2025 10:39:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE342301486;
	Tue, 26 Aug 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204794; cv=none; b=lQWf1Z07aqvsbuG/R6ORyory7q0mmF1mc9Bn46zNu9ofeYN8XUY2QLWMKvYkN++CkWOVP3pKJbYIRuZIUmQcMR1CTWq0uL65Qj47Q2YpALVCsv8EWeYJT51cnq9zLxTQ1MltS6AWq3A8DBiBehoOymUbyIxLCaFUPh2/62mS3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204794; c=relaxed/simple;
	bh=axYdkke8DyT2Uus9AU2yB5PK/ytArhE6ltG77CPIAWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sri3YTDJrUpz7sY7tXSm9ehHFujZcJNQyPFhKMdpYHhxq35Brv97UoUr4v5q+D6R/hiTIVqdIQCDcdy3lXHwNXCJA2XGLksr19GTy6yepy3OvFLRp3lD4p6lNU8eDlZdahqc0daxD5YyRNnZ1D9B9gQ2GQ5tW3wQZ693szotCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 103BF1A00;
	Tue, 26 Aug 2025 03:39:44 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 208F63F694;
	Tue, 26 Aug 2025 03:39:49 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@oss.qualcomm.com,
	Nikunj Kela <quic_nkela@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6] dt-bindings: firmware: arm,scmi: allow multiple instances
Date: Tue, 26 Aug 2025 11:39:48 +0100
Message-Id: <175620475405.1763115.5520957460369024353.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
References: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 14:30:00 -0700, Deepti Jaggi wrote:
> Allow multiple SCMI instances by extending the scmi node name to include
> an instance number suffix.
> 

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] dt-bindings: firmware: arm,scmi: allow multiple instances
      https://git.kernel.org/sudeep.holla/c/a4d5f63d4384
--
Regards,
Sudeep


