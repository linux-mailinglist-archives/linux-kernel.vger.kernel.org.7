Return-Path: <linux-kernel+bounces-835197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE1BA67B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36EE166197
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498292877E2;
	Sun, 28 Sep 2025 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="gJpYk0i1"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CB34BA3B;
	Sun, 28 Sep 2025 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759033599; cv=none; b=cKWRAkClFq2XMVQg9k6xJEv7IYCFbws/1Yu+s6Ef+ryG0Zj0wMVQ7RuircUqwjj2/Gn55rXoBE7hzbtzOvlpNYWu7q2e5EIDgq5ZM/HegXPVZ0Q7wpaXKOho4uU6EVtT1Cld0tPs2AQ50HUR+tOwy5BKM969RVtL4+zuRJaEmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759033599; c=relaxed/simple;
	bh=rLTkZRi3rnk+A3ETcZqBlNg11IGKyfUPUP4yA3M8kcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deIm/1sHqBXizE+9GxFATyHqzTJrDt1xzGu/Ty7PIF0srmlrqo1LkId6PupIIOk3EWzRH2c5GP19yPzkRF35ia55g12b0a0k2MESv9zNvw+5oBF0uHdSAhaGhPaBrUedX+ftw2ggPT+PJKrcyXrqKroW05IgaB8G2VuQSCN2RvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=gJpYk0i1; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759033582;
	bh=lRXKPu9rVdBrwq+A6fNuFBqeLF0wYvpKYrnWz46wPHc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=gJpYk0i1AXEN1QvSfSVYOrcdWJ7Xg5Wu68Nl7qRTzsQXP1vMvCca1Blc+jNsmJZwv
	 AOK6i/oLksIJtUErj2QZmeXjs+QNB6k62n+SCBafbEDBnNpXiMJ4oDvKFs8xWA005u
	 15QJHNud+yHqWZK42hPJzjTFXtlDMH01qHRd1CE4=
X-QQ-mid: zesmtpgz6t1759033580tdb211f7f
X-QQ-Originating-IP: cTWBXFkZ8w5X/RkyEMnZiFBP1OpMPA6Kf2dcxAHh1mA=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 12:26:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 914358563765765743
EX-QQ-RecipientCnt: 15
Date: Sun, 28 Sep 2025 12:26:19 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Troy Mitchell <troy.mitchell@linux.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Message-ID: <C16FB37F0982124F+aNi46yQc_e-gCIvL@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: ObJwB+WjnsjTpjfmMDM0cLdBRYnRryirwMRRwNWAdio0Mkbnct5Uqokr
	PlhWzP/cvKNNf0MXWi4PpotZXcDN47DrgTRRAHgOFbcT9l24Sme5qQVcMP1Cp2uCnpnfJY5
	N8mI9JTgiImmyeZbrTRDxlpIFS9jTr7A75cnlRDbiYPE0JzSsy2SjdT14uqpN2m2Qs+ZH5x
	nWahQh0VNf0Nib5ggbZEyKFg22Ft0q+rfqoDjGv2Tuw+a+y5RamKT+i3hysipC2mUXgQO+r
	wz2Sje2NDcJH+JAhWCBzEzQIvOC8yxWZhqoVwWaZmZtSsWNyEDe4TNx90dEaa9TWYJ9xOYq
	dYJ3IJ0R8nfVoiQZ1eqJ8qq1Sli+f5spYzV2caRIyHCgzf+9TgPG9qx6yXhxAADDVJtcfCk
	fvllWDc258oBoRfeXcbJArUyw0hvIJQQh1NuQosln9KBSdMHbpks/AFO+S0vRWJJLtFpTpU
	JD+u8t2Z2NHfhrYBRY1Lf+dKipSly+HH3dMF8v0BluwS3YOe+zStVX8qtOr54Pt2I4wpldV
	kB+nlW/bLgkVdTbIgIMQhEn/OrdpODHMdmj1+7gMuvwE+lhvDLivs459JsQeqlPGfSdsmlx
	7XrVwO8INJSVnXKyokwuGRypkpe3e/NBSz0/iYlvX83lrqYIYpfIE/ytN/YP9PwHrOEa56L
	7av3yX7fG+Ddl4IRUh4OIfw4iep0/iYJxVBh1UzlpbK1CEiWtv0XkdcJrrvQi+XoirWovuN
	BHezMBPUrHWMConuaKm7ona1jFklOU3QiJfIdQ1jKBSNObL8MzeJd185/aBO4oxkYK9Mw+M
	XAEjd+IrM2ajjgk4UoMY6EUzWjbs5aHpol55uGKUR8R32929Le/5a6Pr8LH1ERApetu47YQ
	UaD1RKL7XGX/86bbt1fAlySAbs05/ErmtTX37n+qxmX7byQWtvTYLMIA2sjKvihLiUFSZ6R
	z22+9bwjdD9LUWmUhAjdMIjHvDxWTPNGka9QIs6RIKSaHBHdoHNXztVfPr4dvysWbCVlvmg
	2jWlWkn8TLzuPIcGcK3yETYiH88UA6H/EBwtTvoSC/PLi74nd7/2M8p/I6kgU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Sun, Sep 28, 2025 at 12:16:48PM +0800, Troy Mitchell wrote:
> From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
My SMTP client messed up,
and both 1/2 and 2/2 were sent from the wrong email address.

                                         - Troy

