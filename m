Return-Path: <linux-kernel+bounces-723440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A897AFE6D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E033A17C83D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816F291C2B;
	Wed,  9 Jul 2025 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="1cs2KLNL"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB53290BAB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058963; cv=none; b=YyHbs7krxjCVu+jAiGPg2dmpiz8PLmUM+s1Bt6RP8x3BD0poFTW7rcmI0qmRzHNm0TjmRDxGhXrmMF0tfFbMBO/yQc6uJvDa/2cNfmDl2345I5ijkkH9qwsGjI6dWm8BJIo2jaRTcDSXvGIrOFbKgHTQUnpkze6S4jNp9+pfBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058963; c=relaxed/simple;
	bh=d/DXj5fq0MaFabV4KFGBfQ/96n0XCm38AtUvJkVYcrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYeXF8lLlWyV739cbAPLDElMp9g5PTvhS2KoMDL6ILUrp/2aOA5ygpJxJnBtfLKgqoSU56pniWyw3klhRJCUaeZDRqohM0munx05Gg4NJJRVV/RFFoQIbNS4imVjDFgpeB7Hx+WZjEmaFjUAk6Jb5/N0yJoPVQjlLj69CyZI9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=1cs2KLNL; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1752058957;
	bh=opPvNMDuTsIOlWJ9taPjmpScbI8mys/Oc7h9aXeb/p0=; l=496;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=1cs2KLNL2WsK2pjNh3CtgGCnggp6ibuzvExe7jPsF7xbj8h1c/i/KSWFVkBV0a9AW
	 vJOTFdEmUiHlJmVpatgkrGRfOLZ60FMuw6aC+9fP+nVvJTd8LSl8hOAXnM8UOhdFp5
	 XvCoDE/TzevXMUO29GT+PwqmS6gI2SoksR6akDzwtdc/tq6oKLo6iocuLL8Dud/EzD
	 21bjkWgB3h4rKIT8xL3iA/TqZV8qgguAECdAwa4ttXgGYzrOtQxJEyrGxt/vKWoF6v
	 33p8GBSRUIo6KfcsnVzsFuUWd5Umu9YDcNgWOASd6Hdc7kvQu/zyPxUextziwg9VCE
	 yevWQ81CvL9Rw==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244572:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 09 Jul 2025 19:02:22 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Jul
 2025 19:02:22 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 9 Jul 2025 19:02:22 +0800
Date: Wed, 9 Jul 2025 19:02:55 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "ChiaEn
 Wu" <chiaen_wu@richtek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mfd: mt6370: Fix the interrupt naming typo
Message-ID: <aG5MX/vVwcOHrjwD@git-send.richtek.com>
References: <a6ab943f4660e39b8112ff58fa97af0507cd89e9.1752026324.git.cy_huang@richtek.com>
 <CAHp75VdXjXgdoZBgKHc-YcGFR-voPboXK8DHbN3ztWuf5jKigA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdXjXgdoZBgKHc-YcGFR-voPboXK8DHbN3ztWuf5jKigA@mail.gmail.com>

On Wed, Jul 09, 2025 at 11:36:25AM +0300, Andy Shevchenko wrote:
> On Wed, Jul 9, 2025 at 5:00 AM <cy_huang@richtek.com> wrote:
> >
> > Modify the lowercase character to uppercase.
> 
> ...
> 
> > Fixes: b2adf788e603 ("mfd: mt6370: Add MediaTek MT6370 support")
> 
> Doesn't look like a real fix to me, although code looks good.
> 
Yap, it's just typo. So should I remove the 'Fixes' tag and resend?
Or keep waiting for other's feedback?
> -- 
> With Best Regards,
> Andy Shevchenko

