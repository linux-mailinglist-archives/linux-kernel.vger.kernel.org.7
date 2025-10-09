Return-Path: <linux-kernel+bounces-846479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A194EBC81E7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E11C188848D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8232D29A9;
	Thu,  9 Oct 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt5vpBA1"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116138D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999668; cv=none; b=A7m9W71Aydk6gS+p04JxrgzMihQitcvQMKUx21YaiRO4n+fcKGz9Hx7blp9mDzLcosziyINPhGWA7EO6uBX8uE5pVHmK61zkgwDu5EyvU2RcyRTp5NUWfU2WHU3mKZMN4RLhCyZrft5DCeBIYnxN9bSoXBGR/kZvZymsxpuxWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999668; c=relaxed/simple;
	bh=Mr7mSsG7wrSbrzRKQ6dm6x5E3zPA4StyIGdQgpwTj7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meyrw3RW74wkDCCwDU1hTE2jXbsqQq9ebY77fBRIo7CJBSPfLxQ0N9xBcqwmJbRHlhVW8kbvAhlkCzTZ8A8SKksCL8SPmkDk/sad7kHyybKleVeqk6RoxTGtiZcXa10WROBnaNTgqYoiXOtrWKSegke9IdD5jnuKA+Kk7qMhJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt5vpBA1; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4dfb1f481ecso9433761cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999665; x=1760604465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7z3HsSENHtLBs81iROjgJgytmIxb+jEUUPbgM1LeHQ=;
        b=Tt5vpBA1u+Mdzw68fb8SiADN/kKPRfbpsyx+lqClGSgkUoXkUNthKIw9Ozw2bT+rrc
         QdAVECPazp6DwUBHDYWy1cErbfwjlCAj128PjoxrAjx14+m9cfKVH2ykxTTan73fMg9F
         WAN/fZVWKEkpWrp0iz711+u3bVenUeSU4qDbEdyV7sksWVgtcpMVfCYs5lt+aFPg8uAv
         pBGeZo5Z+5fTwXHdrpGGUrjq+tSlI2EpQ4mNSX9cdy+oTMtp/K444iIiDLt2wzBFRCCu
         iFw+8OcLHFQ9XdBEs2GTvgdk0gZ66HdGtcvBiYiFo12q5Dr5Njv3KoEffjY+8gBVnZSg
         9esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999665; x=1760604465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7z3HsSENHtLBs81iROjgJgytmIxb+jEUUPbgM1LeHQ=;
        b=oT4l+7JtFYuyIUWRPBbdE+7JMvQerhO8ijoROvrC8floMOZjC3ZlwDS2jD6/gDO/Y/
         bt1kreQMWJzXRAk85HHbnTfqmOqNcp2a+DKrL3VsqLqaThpC6LQIL9uDbWgoTzeFBYzr
         97EQTaqa3rwBGvuOX2Jz0+pjk65VUt4rV0AvJrf5OLh/I09oV1e91rWrY58obhQl2a/0
         pAx0fEciFL+3f2qL9hFqkGHTuI7yhFR623Nzo7cf/vA24G5OW5JocA8unhpaY2k8XTBU
         R5yPm2yvMrQ2OOOfFM+Qd9nKpbgtkOAHqoRrCO0L8mcyMHFlTZ1QtqgaeYyP8kLtKEwT
         GoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKLOfOEMP83wwJ4ZmUGbcuK8E6mRSJIDpb/MJM9B7ar13vzXcLcp1HHWEyljDd/g4AO8z36jvdzXhl1yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/6FtsCdMYjugpXiXkMzMH/xM4fFIy+zte6LUT1nvHm2+4WVe
	4J9hMs7sSj/ADqX+b55PMZLAKHroxLe6dm53JyKRFYAv0X3C+BJ6sV7fp6Jkk8K6E9wiz2PRbk7
	S4rhC+383+mw5sPPszUGOR5I/0kKsagQ=
X-Gm-Gg: ASbGncuWEfZXPYG9lXplNVBywJaQGII6cUy8+5+UqTDkYXRI5flXEPD1WnsyUibuoA8
	clFVryxXUcMnaxCcKsHDEVYuqleWRYo8xxSMlqLJP0SJK5mv1wnh4tq+XANRX2RB6PYpR5WV39u
	ZooTrXwSH5Pdg1juZvdHsTug7/ZmQq6gvVxZRcopDv8cXXeM2ZiH624YlW0usSNUfcfoMrRHrfz
	dm4zbnTLkEriKr9anHO4jK4JHLQ1zyrEzS0iu0sj8zoEfCyQQWWRKA8DF7EPdV9
X-Google-Smtp-Source: AGHT+IHZCtZVjbJCuCzfkElGQPsDTCoF7VlhCNJzNSACyEYAtAeKcSTNYi1LVTtefd/CGrEn+damOcQNkjX8el2dbLs=
X-Received: by 2002:a05:622a:315:b0:4e0:3cdb:d1df with SMTP id
 d75a77b69052e-4e6ead5c32bmr79013101cf.61.1759999665491; Thu, 09 Oct 2025
 01:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929065714.27741-1-jjm2473@gmail.com> <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch> <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch> <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>
 <a0501abe-d86d-4f3a-9d55-c842bfafc190@lunn.ch>
In-Reply-To: <a0501abe-d86d-4f3a-9d55-c842bfafc190@lunn.ch>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 9 Oct 2025 12:47:36 +0400
X-Gm-Features: AS18NWC2IGY_8LtLG8W701XYpA8RXhJynROI-cfRLT0k9gdCMgBYHBHaIfR9D_Y
Message-ID: <CABjd4YyqL1YouMt97MA=CLWJmcFMMr+=xpOKOd6YtAC6jQAO=Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
To: Andrew Lunn <andrew@lunn.ch>
Cc: jjm2473 <jjm2473@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de, 
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com, 
	inindev@gmail.com, ivan8215145640@gmail.com, neil.armstrong@linaro.org, 
	mani@kernel.org, dsimic@manjaro.org, pbrobinson@gmail.com, 
	didi.debian@cknow.org, jbx6244@gmail.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 10:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I also notice that you suggest use {tx|rx}-internal-delay-ps instead
> > of  {tx|rx}_delay in
> > https://lore.kernel.org/all/e4d3127b-c879-4931-9ea0-de7449bc508c@lunn.c=
h/ ,
> > but I think this depends on stmmac driver.
>
> It depends on the driver implementing those standard properties. But
> as pointed out elsewhere, tx|rx-delay are magic, nobody knows what
> they do, so it is hard to implement the standard properties to replace
> them.

FWIW, the TRM for Rockchip RK3576 specifies that the values in
tx|rx-delay control the number of delay elements in the internal
delayline on the transmit and receive clocks, respectively (up to 200
each). There is no mention of the actual delay each delay element
introduces, though, so that doesn't get us much closer.

Best regards,
Alexey

