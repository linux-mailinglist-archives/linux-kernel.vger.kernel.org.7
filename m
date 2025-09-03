Return-Path: <linux-kernel+bounces-798728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E99B4221D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EBE17BBF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F30304967;
	Wed,  3 Sep 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGnE1oZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403FD3043CD;
	Wed,  3 Sep 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906820; cv=none; b=Hi+bKL9t9FZaXadZF1RAzKHxQfVjZ7N/7WkKc9ei5ciwXpmtpsY6lecqGK7vj/nGaAnRRI94CP5tPjjczzyqWm2k09wRSaLMIvJrnKzPmXYm76pK/ZeN+MLI/Vni1R1JbwgpnOFWBO/omuABzHmm+6fKo4LamxXikWOoeRmLiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906820; c=relaxed/simple;
	bh=lvv5D8mnkMTlnoYs3i3HuxRJ3lgI3ZhGxgUn/QmY3UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oj076V26baOGB3iNLVro/WwkcU1vdfX/qquTAWR5XFuQO3OokIVOYeF6OaU2nK1xB9G1GqeFnf9th/xHt7d4Jsb5tPojvIEJfCs+1tAfCxK/0J/Gx4aQOUj6zlaAbnInS5MLbzHSomkJubF6IFLWXt+utakHdI/zmXE7XfLtkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGnE1oZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D8BC4CEF7;
	Wed,  3 Sep 2025 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756906819;
	bh=lvv5D8mnkMTlnoYs3i3HuxRJ3lgI3ZhGxgUn/QmY3UM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fGnE1oZ+39/GuuoRDaaTkt8MY88oEZU5KWK1TUP3Wr1jdXKmEgQIkCCuj+DkbZZLJ
	 85aUZR0NHrhz3PIWsZTLVJiIFkYbd53gnDJmFxm/bObU3P2udHHEbRa0tztPuSdNKu
	 ew1FDTCuquP/YVUMFlzLHuYnTaxYOcbz5pHm6O+zCGMhZ9WdU/9Nn40wP1Y/PjWfSq
	 FbIg9+gIJdb4zfVUU1kHSu6fuYjcS8TPsnWGMQ10yoWh0blkYIyayjZO8QZqIlAbk6
	 8a1D5zZubfGAeEYGozDY8IyEXKEaBDz2+TIdhlW2XPassEPrCXyH51+mCmy9PXwmzn
	 E4dcNNhICy7Hw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso5667078a12.2;
        Wed, 03 Sep 2025 06:40:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHE6u5hJShq0wFSFCQopxGWdcCNkAzR7NWE/oIeqhCIqs5KLwlkmmYc1xHF/hHIEYfrgtWzcMHf4k2WAnL@vger.kernel.org, AJvYcCWn2TMOM/AefxnwyFQs1Gz6fRF+BuTIVPbz7CfyKwwx/BhkAEiCBm47fd9CE/dXRBYi5GOSV7coi4PD@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9INLEqhQ1MT/Ztayr6giBbV1/IvBVJ8Fdms0RDJ+UJnprTpn
	aNA2lBdOKDLBVsbJT7kBjfBbv7l8uuPkG8vqfz8aAiWjXpOwZf6Uq4E8KkPR43yGaoLspViPyhR
	V2nIX2OkXUWjl5U5kET8HioxXooZxlg==
X-Google-Smtp-Source: AGHT+IEI5rONWAGmUuQ0T6juo/pf8XchiICM5ct7ySlMdcsLqlsl5dtas428fYuAutHdVTYx18c+P5yWiK2OhZsk7uQ=
X-Received: by 2002:a05:6402:2547:b0:61a:7e43:662b with SMTP id
 4fb4d7f45d1cf-61d26d78762mr15929022a12.27.1756906818326; Wed, 03 Sep 2025
 06:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829211330.1336274-1-robh@kernel.org> <0c815a7562551caf3960cd38b5d867c80747de4b.camel@codeconstruct.com.au>
In-Reply-To: <0c815a7562551caf3960cd38b5d867c80747de4b.camel@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Sep 2025 08:40:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmTmb3GF+CvidWhzgoDP60tb=BtggMcyEP_Ev9dNtjAQ@mail.gmail.com>
X-Gm-Features: Ac12FXwNsWO5DYzNPykwatojxDlJys_qPpKp_KZ_wSvZHEoXKmrvoXoQmYLtNWw
Message-ID: <CAL_JsqJmTmb3GF+CvidWhzgoDP60tb=BtggMcyEP_Ev9dNtjAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Drop syscon "reg-io-width" properties
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:18=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Fri, 2025-08-29 at 16:13 -0500, Rob Herring (Arm) wrote:
> > The default width is 4 bytes for "syscon" devices, so "reg-io-width" is
> > redundant and can be dropped.
>
> I had a quick look in the syscon bindings and can't see that this is
> documented? The driver implementation behaves this way though.

It's not. I suppose we could add that to syscon-common.yaml, but
that's only documentation. It has 0 effect on the schema validation. I
would guess we have hundreds of syscon's that rely on the default.

Rob

