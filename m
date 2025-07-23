Return-Path: <linux-kernel+bounces-742068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38892B0ECC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F4B189C391
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89E279DB0;
	Wed, 23 Jul 2025 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0PPm3B7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23756277CBC;
	Wed, 23 Jul 2025 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257962; cv=none; b=hsBY/cLz++oJ1cEU79wwl2Z67ST9GQADlnSTZAgviv6B1SRQLQgTnZdXVOA91qeZbf0D0ie7MBSZ2JGbb4ZjfY7k3JGOkkE9uYtSTdg7v1urX0cK/uNMYNhEnwUhbg31FOT3WvGioL1I7Db897DkjdKm7ajE1zVu+LI9Bzv2tCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257962; c=relaxed/simple;
	bh=X/CAcZckTuK5hitg2f6i5nCCQw+RUx8Gwq+N1Zti844=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEFmsJecDS5bhdaVb6XRbsi7bXGk1BMHXXIwHK4+K9EEMkvPDeRa7HNrA6Sg1+7yIFxWmJkoU4Ofx72SMVqlTxp6443mE2rIualp7GIv1FecEiTHoDYoBcd07XXoPnNsl62NIuev+OS8txJ8MqecEYZJ6LotVIozwsNbUdUwkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0PPm3B7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBF9C4CEE7;
	Wed, 23 Jul 2025 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753257961;
	bh=X/CAcZckTuK5hitg2f6i5nCCQw+RUx8Gwq+N1Zti844=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0PPm3B7ryEdUtbUQKIfiVtrZardJAB1ol7aHlT3Yq7VTtz81Qt85Q+/Sj+BI1gK+
	 hcnc8MAe9/RjoiKrH8w/r6SQ1Nv8mOdDK1FSuqYFnMDDPxDuS5eIhXXIQgiaI70CAZ
	 EMzov/3R0KJYXwX89YAP4S2eZYMAQlbJkUuH84xWX90PIJFWzuEVUuinlN6/wU31bo
	 CC/l1FvgNDltepvFIhu0pA/3r/B31BT/bfT48zY9uOYGNsSOKiOmlQAp2EF6hpynV9
	 yw6RAGpDs/W95IxaOny9HyR0decYah1xeHhbNOYtrGVD2ayc9eEXCc7vX6Y2sdQRx7
	 j8ypmscJJk7Cg==
Date: Wed, 23 Jul 2025 10:05:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rama devi Veggalam <rama.devi.veggalam@amd.com>
Cc: bp@alien8.de, tony.luck@intel.com, michal.simek@amd.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, devicetree@vger.kernel.org, 
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org, git@amd.com
Subject: Re: [PATCH v2 1/4] dt-bindings: edac: Add bindings for Xilinx Versal
 EDAC for XilSem
Message-ID: <20250723-splendid-brainy-capuchin-cf52e4@kuoka>
References: <20250722160315.2979294-1-rama.devi.veggalam@amd.com>
 <20250722160315.2979294-2-rama.devi.veggalam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722160315.2979294-2-rama.devi.veggalam@amd.com>

On Tue, Jul 22, 2025 at 09:33:12PM +0530, Rama devi Veggalam wrote:
> +  Xilinx Versal Soft Error Mitigation (XilSEM) is part of the
> +  Platform Loader and Manager (PLM) which is loaded into and runs on the
> +  Platform Management Controller (PMC). XilSEM is responsible for reporting
> +  and optionally correcting soft errors in Configuration Memory of Versal.
> +  The memory is scanned by a hardware controller in the Versal Programmable
> +  Logic (PL). During the scan, if the controller detects any error, be it
> +  correctable or uncorrectable, it reports the error to PLM. The XilSEM on PLM
> +  performs the error validation and notifies the errors to user application.
> +  This XilSEM EDAC node is responsible for handling error events received from
> +  XilSEM on PLM and also provides an interface to control scan operations and
> +  fetching the scan status & configuration information.
> +
> +properties:
> +  compatible:
> +    const: xlnx,versal-xilsem-edac

Implement or respond to previous comment.

Best regards,
Krzysztof


