Return-Path: <linux-kernel+bounces-829521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2ECB97432
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEF320878
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8D30216B;
	Tue, 23 Sep 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+4NDdnw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50872FE077
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653993; cv=none; b=nCIA53K+lZ+YSE6iUiVD/g83EKXprReI8ud7mJs7kSq/PVVEJcR0ACrzLFAaz5ZTFHXp48V0OmbB3Y5le2/M/3Mz1g1av9qX+YpKGMQLyOjVPRpQUvHCy//pEmwHmVLP+t659k9sm6/O0b/FgtbegLQUIactHVBOgRiU9Swu1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653993; c=relaxed/simple;
	bh=DWcgQoC7mbLIcOae7OLDIeE5ye70Nq22n9Jh3BH3ixE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVRXBCGi+EMjg8+aP96XaZE0EUP3ax/ZgOTHSgExakLkhmLxI/vnApwjcpnU/SViBB+kDbFS1f2Ikn6cPZR6UtEUClDUEYBIz/jgqNrT1/DQMcwbs4k5ffwM88vU5IYFSqlBkGSlizHI1wCXAOmNGbuF0jogQTVrKZA33uy5DXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+4NDdnw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so7689917a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758653990; x=1759258790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LORB79saQtcNPiyY44B6K0FPB3bszS2VB5LSvhgyj0k=;
        b=Q+4NDdnwc5FV4iltYyv1orIoLQPw3BpDoi9qEnGN8ZQo+vm7NJdcz8aMhQZf8C/i4/
         vGA8nwcta7z+Z9MR8Jh4rBccRziHGpkOr/IbrgGtPO6o50pPM/T5j597HMvuTFyQpmGD
         kab5SKsQUw5x8Fsso7+dpAxu0GP4mL/oC//6V1UiGixiwBpJodI0Gvp+2sduxrMkgjgV
         ZM7W/2Lt5itEe58FdMJV8SmujNyH8a8Vg+QD+K6uigu3AOMgjRSsU+8nNr0/6m3pUpXf
         VSngb94yAINIqIbP5d+kq/bvuwxD1Mc38OIjsePRkD8h8/I2MISnLku+kj/m3bpOLks/
         OePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758653990; x=1759258790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LORB79saQtcNPiyY44B6K0FPB3bszS2VB5LSvhgyj0k=;
        b=pIpq85FXnShod3BJXd0f7BVEKna21RERDbMAu/HdVXltw9iaqabPQ9fI+WAqCcHC3I
         tOG6D0vCVDuhdDxLMtsMVt2cqj2+XESQOEbtFG4/AgK9lvCSwPmjcw9Hvne/i6fpuG7m
         1KQLNrQLalrpNMJ6ic9/BJi/YYZcOyJmzfzKKekwi2X7pR2cYflCPUVPKpF+0E1dLQMl
         dEaiMhYw5VGFcifap6gtIle6EMDSCmBWQecpdUfES9wTbpKI0nCR5tdEXWR0HiAQoHe5
         Xd5K9XcQmuHzBdT3l6EIJMlLOFmvR69fHM2bgbKyxeUWedmBx9q0mK+rjx1wOgivuLeV
         Wl4w==
X-Forwarded-Encrypted: i=1; AJvYcCVSOCCXjl3pbCiQ2093Gv1WDLC1hQV0Ckwx/FF8sM0vUNRzwKNvqHkaEcdSXsKiidLhINTXG7OAYxoNSqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWJjyLpzoYpPKrjLpMZcYXDa9Iv+k2KDOPpvD0cF3FhtN8upd
	cJQ80uJ+u1nePKpse1/P2nLL3+uHqPuqEWnQPxIl6LdXNFCv0e0mwKVgs2skW8IJOgc=
X-Gm-Gg: ASbGncudPi0oy6SF4e9/gekUCHM1AnZvqYQYo8oOn0T0tmTqG6mFCXcFxhEGL57QZaN
	yCXaAgbbtI4z1bAJBGb/BU7yUd+g5A9kGMN4ln0h0NXgOW+fTwxPLwqaIUfPPzeI5rgZZgpzu6Z
	nCerU4w3wvRN1XkbSCkwktggom1DFRwxrLE+IEhJzoYpAw+rRXljBu8M+7Osy+CJEFS+JGzpURK
	YRYCxf0Pl1lbicY7AOI8q+4Q/E7OOzz78aUVTYH8YxXgJvlpn0o/WeONbS+LAAQSq0EvCjc1jkh
	iPz/DYuEWPqQaMwfw98LDm1K6sTUBfUirp50lD61n0MfExkz6gXGBY/x4e+5fWslXLxaclJ2QIB
	jLhZPj6AYL9e25XleblrMqXJYIVoT6iL0
X-Google-Smtp-Source: AGHT+IHpNDrBMGpbrr+jACB56SjeewurC5sNC2bfrGwwMx9GpqNnbrlv/Ka/PcBzermBd/G+tFnJ7w==
X-Received: by 2002:a17:906:6a28:b0:aff:fe6:78f0 with SMTP id a640c23a62f3a-b302c20390dmr373202366b.54.1758653990098;
        Tue, 23 Sep 2025 11:59:50 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:bd4e:c20d:5910:982f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b31a562fe38sm86252966b.45.2025.09.23.11.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:59:49 -0700 (PDT)
Date: Tue, 23 Sep 2025 20:59:45 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: rename x1e80100 to hamoa
Message-ID: <aNLuIX1wcUYMpVBp@linaro.org>
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
 <20250923-rename-dts-v1-2-21888b68c781@oss.qualcomm.com>
 <aNKAjIXT3ll3L0qT@linaro.org>
 <f5kgh4hivkrxcfkinberpdxdnyybw552zqup66cmobtgqag477@qldaejueyyr3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5kgh4hivkrxcfkinberpdxdnyybw552zqup66cmobtgqag477@qldaejueyyr3>

On Tue, Sep 23, 2025 at 06:14:45PM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 23, 2025 at 01:12:12PM +0200, Stephan Gerhold wrote:
> > On Tue, Sep 23, 2025 at 02:01:55PM +0300, Dmitry Baryshkov wrote:
> > > The X1E80100 and several other similar names (X1E78100, X1E001DE) all
> > > belong to the platform now known as 'hamoa'. Follow the example of
> > > 'lemans' and rename the x1e80100.dtsi to hamoa.dtsi and
> > > x1e80100-pmics.dtsi to hamoa-pmics.dtsi.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi                        | 4 ++--
> > >  arch/arm64/boot/dts/qcom/{x1e80100-pmics.dtsi => hamoa-pmics.dtsi} | 0
> > >  arch/arm64/boot/dts/qcom/{x1e80100.dtsi => hamoa.dtsi}             | 0
> > >  arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                  | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1-crd.dtsi                               | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                        | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                       | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi        | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts            | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts             | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1e80100-crd.dts                          | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts   | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts           | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts              | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts              | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts           | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi           | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                          | 4 ++--
> > >  arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts              | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts          | 2 +-
> > >  arch/arm64/boot/dts/qcom/x1p42100.dtsi                             | 4 ++--
> > >  21 files changed, 29 insertions(+), 29 deletions(-)
> > > 
> > > [...]
> > > diff --git a/arch/arm64/boot/dts/qcom/x1p42100.dtsi b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> > > index 10d26958d3c66a5a4faf2ca6065e7b661f967b4e..2cecd2dd0de8c39f0702d6983bead2bc2adccf9b 100644
> > > --- a/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> > > @@ -3,8 +3,8 @@
> > >   * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> > >   */
> > >  
> > > -/* X1P42100 is heavily based on X1E80100, with some meaningful differences */
> > > -#include "x1e80100.dtsi"
> > > +/* X1P42100 is heavily based on hamoa, with some meaningful differences */
> > > +#include "hamoa.dtsi"
> > >  
> > 
> > If you're renaming X1E, please also rename X1P42100 ("X1(P) with 8
> > cores"(?)) for consistency. That one also covers multiple SoCs.
> 
> I haven't checked if we have clearence for that name.
> 

This is a good chance to ask then? :-) I'm pretty sure I've seen it
being used by someone on the mailing list already ...

Thanks,
Stephan

