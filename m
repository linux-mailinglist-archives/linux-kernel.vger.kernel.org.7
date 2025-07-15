Return-Path: <linux-kernel+bounces-731134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E745B04F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B9B3A73A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833942D239B;
	Tue, 15 Jul 2025 03:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCwqJ8Ry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E12D1F72;
	Tue, 15 Jul 2025 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551926; cv=none; b=qtraYIBrMw+jlDiYyo9AmuCnaGDiRkE/9uTEs129Smx76e+bLg2aNn09sqnEjErmtkfKJZYyDink+87xHEYrYPrl70dAG+LnUZOHnzfLTpuchndF4yHCsvb9of5q6eXro2tqp63+A+dlrIfg9XKq7YknTN0IrS3fDw6rhCCo5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551926; c=relaxed/simple;
	bh=E1bP2qyrdHOflkUNF5HIzZ1cwKCdQr2yzEaRreh3xcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0FRq27TUXTubyIA507j/1efUVMZtsETQ8wvSEL15ziSG8r24QD22oBiVDeeITEGhlyjWsPNDk4pCAvPdaYb450wkHTqmiuihKFId3Kk1tSVnoiTB3C8Xa7w59wbmmyLIdwUxBaOQ6dFyNL1VyZ2OiTWmr4oSS9KGcyqQnC8318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCwqJ8Ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A22C4CEE3;
	Tue, 15 Jul 2025 03:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752551926;
	bh=E1bP2qyrdHOflkUNF5HIzZ1cwKCdQr2yzEaRreh3xcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCwqJ8RyiHOZpyii7xllAANTbVcSC47F0pmFvRK+AK2LUU/o24PyFHn03RqffxClA
	 jJYlGYh0vlU8CBMSR74UZs+CxAhZb3SL5l6+FhXqDwjYt9a0kzM6HH6+SYh8L5e9nN
	 6+feukmQHpnCic44wuNHjRY0WSmu0LhakmtKYhUbeZnCavbCAI4BHZqIaupVn28QCC
	 vnGqb2ozc1dvBqEyWktYUjPy/g0KxBig6qUa3KcVOkJ4SqGui31Ovs4BrbEYJprnjY
	 i1DAb9BoJ7EYqDALGC7elsaJTnpf7T36DUkDzG+M5Rq/dIWLJ9mayNzh4NQGz750Uo
	 ErvL5OcBLjE5A==
Date: Mon, 14 Jul 2025 22:58:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dale Whinham <daleyo@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?iso-8859-1?B?Suly9G1l?= de Bretagne <jerome.debretagne@gmail.com>,
	dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: display: panel: samsung,atna30dw01:
 document ATNA30DW01
Message-ID: <175255192501.20738.16784196888105498389.robh@kernel.org>
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-3-daleyo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714173554.14223-3-daleyo@gmail.com>


On Mon, 14 Jul 2025 18:35:38 +0100, Dale Whinham wrote:
> The Samsung ATNA30DW01 panel is a 13" AMOLED eDP panel. It is similar to
> the ATNA33XC20 except that it is smaller and has a higher resolution.
> 
> Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


