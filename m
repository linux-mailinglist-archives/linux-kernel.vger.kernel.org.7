Return-Path: <linux-kernel+bounces-723528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B30AFE806
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C14A4F59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB95B293B5F;
	Wed,  9 Jul 2025 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Fgg+2Y"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E414A60D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061535; cv=none; b=B87as9NbbyrBfPpS3cosidO1v3a31BMTlZzE5xdNqsj68Z8deoQl5YShxPxJyoa5JAsIPrGOy/UGPjNFIw1k1e+O5VXC1qn2/LmbciK3FlCd/8wRkKGTDYGm5EtOVduHfiNGDDVq8ukfaJVK51K/oYFkMfh8XxgmDI202PzB7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061535; c=relaxed/simple;
	bh=lXteknH0WiQVFT+unp0MqgDQgccbzHHGuQKDjiH9Tvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AzUxk1lHhq1CYEya7lvZvv3luJL3UIzZVebPTGLNGiSOHUtfxTK5T0SqilYgatTTNLUND2o3yzPsxtNXBHx6nlroNFjuHMPbqyHwjavKiwnsNwFKXcezsV/izjjcUJy4Op3704keuISK6Uz3J93zFH6N819x5Tt7gvCDyALajhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1Fgg+2Y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-879d2e419b9so4278064a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752061533; x=1752666333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BmmE+ZvJPR6oGSAShFV2FgbxlwcSMnJ2ZYq+K0udWPw=;
        b=F1Fgg+2YU+rTRTDrBx3FLEFjlAJPUSSl5w1UQiQR4wUlffPvsLLNRcDSAhDw9PxA5/
         CXajgZV0qe1NAxhkAQAHLVVO4iuKKNpeqUx9caPMK22FZa4sg/7ZMTvZ+pOxfv40i7Q7
         oIQjAiv8dcTb2d0R7pNhIDDF/sFEZ/RGWjffJBRY0OtEBdY3+mFQIWNFwZCO8lfDt3Bx
         +j4N7p5ckLhdJqgwmej1aupsa6RaMeuNJ3vaBBs86nEUPccrBmfgVOk+QSNv844Bs719
         IDLR01HnkwhV4v4KYcUTEDM/QWlp+NDvnaYklZ9XUZtGUmOw1nPROa8I/1nKrG40zfha
         cxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061533; x=1752666333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmmE+ZvJPR6oGSAShFV2FgbxlwcSMnJ2ZYq+K0udWPw=;
        b=OP9TTAlkh2s/caMqmUGQVNml669awv6gvxSZdPatWNLNNaw0wtIRn4+Il11vn0JuG+
         L7btRojobGqTYA2RaH0UPnpsETPwATM9t46Y409Mw+Kzbmce2Q6UQ+uHMtW73/aye1x4
         lIrDu9w+crxyC8pj+Fwz8vnXci4CkBzc0dBO3wtC8qsJVbjMhO+CJ+46xoSpv/Q7eWa4
         pFIAfYXjkmnw6QGPUoNrP646o+n/YkRSrq/psgwdP9ACTCkLrQMql61ZqTGU76sniZ1C
         7izhgnB/h/v+9YTArUxylcNlfMwNZn0TNpN1B0rfyP7TWaCYNo2MnKmYpaxdqW+Fzqip
         82Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWnjh+6nwg5zSWIY9Mb5XSg3BTFg7iylQBkjpHN+4xTiHehLiRTaqAxWU6NIWdI54SRuPj2+RGlSWxSx4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzLZeqJEpMMOk0DpwNhNGmtAHH4bxQzTt7Igdmlpck45IdGxR
	QwhP1f5ZD0KE4n3A3qvoHPbKzhjzT8RELjIRgbrOSijYVMLSJhyEo6WOFR0DU1ulXwDwLINcpWh
	4tZWsfwcK+E41ut0Rc78ePvacGe2w1g==
X-Gm-Gg: ASbGnct64N6NRCtKSLav7747FnZXgRUBJdhtdlhF5VhbwVLjg8O4VPy7Rbcq4WjRg3e
	Deg7OsUl/MAn7Sj/BeiZph90YFFCIAVXzrUrKpSngkgvan4MkOayB3SAOh/+3ZHyFVkMGb1Y9/z
	4fKjcmH2Hm1D/BNu43BkndBm/y1crB1xlRkRLHiPUnCHcXb1wL0Zv+BjYOr/lWHdCi9F380ONtG
	y5I
X-Google-Smtp-Source: AGHT+IHsP2TAZOk9rsqB+paL+wHnXHKFH1crGCu1hgMUt07KQJCg8BJz7PPGw9RCEIV87AidDU1pWs8Cip8GPH1988c=
X-Received: by 2002:a17:902:ebc3:b0:236:93cb:48b with SMTP id
 d9443c01a7336-23ddb34434cmr36434895ad.44.1752061533265; Wed, 09 Jul 2025
 04:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjTZvZgH0N43rMTcZiDVSX93PFL680hsYPwtp8=Ja1OWPvZ1A@mail.gmail.com>
 <aG2mzB58k3tkxvK-@audible.transient.net> <25642e5b-25ee-49b2-b08d-4c64fa2e505a@nvidia.com>
In-Reply-To: <25642e5b-25ee-49b2-b08d-4c64fa2e505a@nvidia.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Wed, 9 Jul 2025 12:45:21 +0100
X-Gm-Features: Ac12FXz0xyncJrPDgXwux4UGvTbFTmk_zafg_rpj26GR6Zjp2-JF_HWcaE2aOvI
Message-ID: <CALjTZvbwY=wLvGAJvFb7q9G038FNjR6jG5L3eEGJkoEd5xiP8g@mail.gmail.com>
Subject: Re: [REGRESSION] NVIDIA ION graphics broken with Linux 6.16-rc*
To: Ben Skeggs <bskeggs@nvidia.com>
Cc: airlied@gmail.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Ben,


On Wed, 9 Jul 2025 at 02:15, Ben Skeggs <bskeggs@nvidia.com> wrote:
>
[snipped]
>
> Thank you for bisecting!  Are you able to try the attached patch?

Thanks a lot, your patch fixes the issue for me! Feel free to add my...

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>


Kind regards,

Rui

