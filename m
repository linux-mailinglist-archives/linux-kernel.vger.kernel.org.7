Return-Path: <linux-kernel+bounces-808080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D86B4ACEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC9E1696B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A12131B800;
	Tue,  9 Sep 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HB7JOBq0"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92D2417F0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418812; cv=none; b=nJXlN2qskHl0Gb7El2TpQ0UkQ7719WWhyroAmC3OFUj1Llv3k92oLGSUkuDBGl6/Vl7fBET6OjGpbTUiJotQMtdIdzVfU70zBjkBkfGdbNjogV9aAkHGMRmOk8+Hwk2Gv/tiJ9Sjm4V7JlaMV7ZyoEjFBZr+mpDqaziaO7bjiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418812; c=relaxed/simple;
	bh=ZXsBWUVEToRG9hwWAZ2hDQlZcigvLyFJJHvcWPbMinA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ndvb9AZfD6eTR8veKxey/4t639nXiaCIoXamBm43+aVpFuL78lEMuW9dqpQggxs2BLgA6NAa4+3mxdoNmJIXU+hJO2Pzz4OrCP3AvtrS3xIg4ji/R0U3hUQLzQ6e30iZZXlX6p7ahekosSib3CX/w23kYtu3kjO+tAfB1uy/smc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HB7JOBq0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
DKIM-Signature: a=rsa-sha256; b=HB7JOBq07d27/uRMofVuysMRx3jKZ9qs285MC087RL5HNu0wBaPGA2VzmF/ipF2AX9XqytGqWILeKp3++xOFMLiyTlHtVkSd1c4nLBRpDxKEnINMBHTwshtKLnYBuv4Pvki/4/f71mPbZeHZlX8CStVVjTWjUb9MDbBjzlqMASFGjojdqXM3IdDB5yxN4R5BBsWUDaww2l3d8IYjROpEI2QKgxmJjFDOjCRgKD/0PDD/boXCtwhpnFd7iPyT9RicWijUtUoxf6R/QVPN3lOZcf/gs2HKWU8I4hL4a3mWrPPg9gWJrECpQKyZb0fr38ONjid1Tk+atU0pF5vgBm6QJA==; s=purelymail2; d=purelymail.com; v=1; bh=ZXsBWUVEToRG9hwWAZ2hDQlZcigvLyFJJHvcWPbMinA=; h=Feedback-ID:Received:Date:To:Subject:From;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1767750111;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 09 Sep 2025 11:53:22 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 13:53:20 +0200
Message-Id: <DCO8YZ9DEAVI.3PUDOLPOHR1T3@mentallysanemainliners.org>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 2/4] pinctrl: mediatek: Add support for eh bit
From: "Igor Belwon" <igor.belwon@mentallysanemainliners.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250908-mt6878-pinctrl-support-v1-0-3fb78c8ab4e8@mentallysanemainliners.org> <20250908-mt6878-pinctrl-support-v1-2-3fb78c8ab4e8@mentallysanemainliners.org> <80a7339c-4742-45c1-b474-347a916b2db6@collabora.com>
In-Reply-To: <80a7339c-4742-45c1-b474-347a916b2db6@collabora.com>

On Tue Sep 9, 2025 at 9:57 AM CEST, AngeloGioacchino Del Regno wrote:
> Il 08/09/25 21:17, Igor Belwon ha scritto:
>> The eh bit is used for setting drive mode for i2c pins on recent SoCs.
>> Add support for it.
>>=20
>> Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
>
> Noupe, this commit is not needed at all.
>
> I get that this may be tricky to understand... but summarizing, what the
> downstream calls "EH" in upstream is "DRV_ADV" :-)
>
> Check the comments on patch [4/4] about how to change EH to DRV_ADV.
>
> Cheers,
> Angelo

Whoops, sorry, I don't know how I missed that.
Will change as in your comments and drop this commit.

Thanks,
Igor

