Return-Path: <linux-kernel+bounces-834250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57DBA4431
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821621887AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D0199E94;
	Fri, 26 Sep 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElFc6G7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BE28695
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897546; cv=none; b=JCz9xY4/k+cbRghJY7Pj+EYxSqsDB6KuNFlBVC2GEhk+i+/SAwn+lkbe+4KOgQ7yYLUAfEobwWlmeLpxQ+mwfaNczCbV4KsejZUi0HZ7frWRYbiQi/LMkj5bkKpjYKdBsqHV59aLC3Yrji9UrVpdtSEo4PSqZKGOQydN5binuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897546; c=relaxed/simple;
	bh=GR3UhQsht5K0Jwq5rBXb9dgUoosX34C002/S7elTLUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piUXUV54f+LMdbHxpA38H31k5jRdxZBLnuPljv8i9oVI1bR6/IPWQiPnXEzuZJKDlMrO1xGEMFB/FrNZOYIzFCbEifAsDkOCSshAlljn2H4+FsD2rSQQ0nwRWjL+aO9jSfKx0wCD/+jajRMHPdtK7t6ffUM4o3MFZMhv3TOeTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElFc6G7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57749C4CEF7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897546;
	bh=GR3UhQsht5K0Jwq5rBXb9dgUoosX34C002/S7elTLUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ElFc6G7eZh2BJ0ifxZKpR2ZW3aV40Xpz93WcjrYBNqlFRkd4KbJnGk4vBbqr6fzE7
	 rWks5qlWg6XaYE8iGxaZ0oahv381AUWBEhjA/ZjDWIgSpGzic94sEXEuUdxIbWJYhD
	 5Sq0Jrarm7ad/NszVDm0BX3XLSCNJCkrCm1y/pwixANkxQ+tWsk5bpixRzr0Yn6u0S
	 RzaFH9VWX+YkwcBryUCfVluRe2q0/dPDxg+CzozyIICwIArfhqFcUCuaSJOJHCE21l
	 g7i/dj5ZoxrndeIiMW4wmAHpQJe5w6vR78GIJC0pOyqNGXoqSe5FDhMVebAj5IX5Dy
	 fv2D2XargmJ5w==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74381e2079fso2087264a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:39:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyzgATlrMDmwmIq10g9m35RJKN89fBpw3STQL4FnovCWDhTISKPk4Ntvq1SoXyssNByti1moWvcisG8f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOCEMNpozcZTZWbIUwSxgfraMp9Vu4rwiXc2BErkFHWQt8Hn7
	HJQn02Cs2s0XO/887UR/lIsQUWYMrObtm/Y5c6y3qxhE8uVSzC6/69sOYsZ3L3Tk4D7URBVSwdd
	2vrnmA+gOz5BVSBMSGETk8vthlpVaa/Q=
X-Google-Smtp-Source: AGHT+IHJHaKvdI68QzUrzIAL1Tex4SlePhlPJbUCP0LntCMfCY3uISEcIn/T2FEFBcTugpvP2WZJI6kObdQ5unAgV7g=
X-Received: by 2002:a05:6830:6615:b0:745:9769:ea43 with SMTP id
 46e09a7af769-7a048362392mr4417572a34.11.1758897545660; Fri, 26 Sep 2025
 07:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1950293.tdWV9SEqCh@rafael.j.wysocki> <20250922185036.GA1983521@bhelgaas>
 <20250926150613.000073a4@huawei.com>
In-Reply-To: <20250926150613.000073a4@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 16:38:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hX_KwigOroX1JNMEPbNF5R1csN7zJVenKAPTHtzxQ_Qw@mail.gmail.com>
X-Gm-Features: AS18NWBV8t3xxNWpfT7og_6rkg4uGmPJmoV5hPwGaOLV6FHNIUYqC7HibpY3w_0
Message-ID: <CAJZ5v0hX_KwigOroX1JNMEPbNF5R1csN7zJVenKAPTHtzxQ_Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/sysfs: Use runtime PM class macro for auto-cleanup
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:06=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 22 Sep 2025 13:50:36 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > On Mon, Sep 22, 2025 at 05:31:53PM +0200, Rafael J. Wysocki wrote:
> > > From: Takashi Iwai <tiwai@suse.de>
> > >
> > > Use the newly introduced class macro to simplify the code.
> > >
> > > Also, add the proper error handling for the PM runtime get errors.
> > >
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de
> > > [ rjw: Adjusted the subject and the name of the class ]
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Being half asleep I went and  replied to v1 when v2 and indeed this v3
> were already out. Sorry about that.
>
> Anyhow question is why not ACQUIRE() and ACQUIRE_ERR()?

See my reply:

https://lore.kernel.org/linux-pm/CAJZ5v0gnqoJ8bALZT61ZvTA=3Dchp8y5QBiA7ZpNQ=
6fFJuQzZUnA@mail.gmail.com/

I think that it can be done though.

