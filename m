Return-Path: <linux-kernel+bounces-843426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36FBBF284
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23DE24EE95A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62E2D5A14;
	Mon,  6 Oct 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGuhMkMh"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD316A395
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781489; cv=none; b=A9TV+tAAQ16VwmnIqWntCjjURiK7lh7AuXRu2259wPsPp8lj2HIJ4LREobriNl0ZYJHDyArsMx04gxbGY/vaEJE5LFRjRMO+s9LQseC8/TsX/MzytMg24rSGwyOJlvUIMco/ewkDm5x92A7yPfM7bam7LLwsAMydHfwSmHnPDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781489; c=relaxed/simple;
	bh=J8B8d5oivt7QHGu0AFEWxVKZLm8dbp7BygGpbufIGdo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GUeJBsOqI49wrCC4Mb0ugpKelZ0OWYIrP8AaPEMsyHgyOyi2NZERsZvcwFSs2zp7aIxo+uXS0v1K39BdSagLu1uZ9IkYwQA+eW/XiL7NSubDLwleLwtXfYftLiE6DbcOkL5HOpEKAzHJeBfGe0rNef/PuBJl/fUIfcF9l0c+FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGuhMkMh; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so6547832e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759781486; x=1760386286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8B8d5oivt7QHGu0AFEWxVKZLm8dbp7BygGpbufIGdo=;
        b=iGuhMkMhnm/oFnFu+NpfQq/4WZRzGZLKivzvscJ/2DpqLMvqWfCj/nRNyzhW2b1/QH
         NpKcR/qQ858B+tULAh4GHoLr3oDbxgVhi5l2l+9PUXEAmncJcF6O1msPHfoBgUo6TC56
         7lBu8zusxoNuthdkEtCCOtyUcFbV87S5Bzk+kN98E5kn+OHU37jri7lWYhi3hboVdi3q
         wGljvflV/clz7RnDk2IUQ0WhTBvx07bbXfc9Oaqs3TSOzZiPLVMaqYmzczkPE/zNB/V7
         NQ5Czo5lGVB6BVSYFduAUw1HD+RsCzbX6YjMLPQ1FHqKoPxjo4DLqFM3arLOrILLTVFb
         YgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781486; x=1760386286;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8B8d5oivt7QHGu0AFEWxVKZLm8dbp7BygGpbufIGdo=;
        b=f+2lfVIIlI6v0Wh5jwVdiq9aewBVw/dGp/ZNc40XsYlKYJBw36BGK9eVwmZ962iYlR
         V6T4ahM0QxBE9GvP4hzV9jYu7f06ELcPLIh77x3SzK+73CdIrugZERRQNNUHgeifb+rr
         AQeL8TYto8q81OsSdiRQt+2MRuF93slRqbpC92YESNtFPezArF7feOPlJHKvhCz5iCY9
         vY6NxEVxA6qCAf+E0Uuda6kxhgF1B4TRqmbRoGfL40jc4nuqEwuFmBzwlEhkv5OLrlr+
         EPS/RY26h+GrggwWeXVq/J1EWB2My1bMy97aKIFRTkGnTwi0pcgNw6sNcjSjTRaQ73ao
         5qog==
X-Gm-Message-State: AOJu0YyqlPZ5qJ9+yLvIM5q7YCqn77/zH6MZX0n7H45cIDj8n8NQAOsF
	hrtGuFYAl5R5X9IQrEuAuCIRtos7vtEhdn5ay0/bW9WT866HaGybeRDwKaoxMg==
X-Gm-Gg: ASbGnctZxh1+0QDOBm4rE2Vx9F42QkBwB0ExXlMI76fZTb/1D69DYV3Dn92g43zxkFQ
	/45XJ60fC4h7hVw3Rze0b07/6zZLvr3C31Hq6MauGatcHmzqwvbKvvJtABqGN2/Z3MQp9on8IUV
	g7Cn83DTx2Ld0gc8jx72zoXjVPteDWRkAqh+xGW2PgBbxTzNSoivkVNKCVEC2TRlybf3jGl4JTz
	P2IIPL5SOOQeyXJMs/1zAKTexbLM1zJaov+S1hH+bJEbUOhJe9cK1XWkuyYoo30WRFaTgUS7DKN
	q1hOu3d3oGfuTSVxAXTBhikRKBA5db3YSYywlfzfEueY6FFn4uIwXPqEyBzXpsVA+VeCV36VIIq
	tngbrBL+xB1VSQ+8Hbog9m4LO7q/u4IHS52ZSaNw1CNMof6/Y+Q==
X-Google-Smtp-Source: AGHT+IGvlXhE/iAePTd8hZP3ZADdw8afy58n5CCQYP01qe8IgTuBIP+NJVaS6R2EGbkoHgyfPTGlag==
X-Received: by 2002:a05:6512:3e02:b0:58a:fa11:b7af with SMTP id 2adb3069b0e04-58cb9a3934emr4032325e87.14.1759781485607;
        Mon, 06 Oct 2025 13:11:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011ab24fsm5348768e87.120.2025.10.06.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:11:25 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Ulf Hansson <ulf.hansson@linaro.org>,
  Shawn Guo <shawnguo@kernel.org>,  "Rob Herring (Arm)" <robh@kernel.org>,
  Anson Huang <Anson.Huang@nxp.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
Date: Mon, 06 Oct 2025 23:11:24 +0300
In-Reply-To: <CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
	(Fabio Estevam's message of "Tue, 30 Sep 2025 16:11:16 -0300")
Message-ID: <87o6qjaiz7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Fabio,

Fabio Estevam <festevam@gmail.com> writes:

> On Tue, Sep 30, 2025 at 4:09 PM Fabio Estevam <festevam@gmail.com> wrote:
>
>> I tried booting 6.17 on an imx6sx-sdb board and it booted successfully:
>
> I forgot to say that I have used the imx_v6_v7_defconfig.

I've checked that I end-up with the same DTB as you sent me off-list for
this configuration, so at least this part seems to work fine on my side.

I also tried the imx_v6_v7_defconfig - based kernel on my board
(obviously with my custom DTB), and the kernel still doesn't boot.

Further, I've found that it's enough to disable CONFIG_REGULATOR_ANATOP
in my custom kernel config to get kernel to see eMMC card, and then
mount it as root file-system.

I still fail to see what I do (or don't do) in my DTS (or kernel config)
to confuse the kernel, and how to figure that out. Any ideas?

-- Sergey Organov

