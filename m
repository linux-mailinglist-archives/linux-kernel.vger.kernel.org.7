Return-Path: <linux-kernel+bounces-766547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A91B247F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97EA720A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477962F6564;
	Wed, 13 Aug 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMRFP7Y2"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B221256B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083134; cv=none; b=n3fnN4nYU3CFqrCQtqYLOacODtC7elLS3vAtp5zKGoWRMe32JsKEPWxQVUgOMr5PvxOALugcHW3OFESi0mA7UywbLnyta2a6nutmRJ1yLmjx4WLliEVYkcrSYRzA2Tbf3UUflFhrx2ykrZQzBrmF0IwwMBwn1pvbbJmN2qLheJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083134; c=relaxed/simple;
	bh=VAU+zceNWMs0ZEPv7KyAXNBpYbdpha+WzKllqlveQak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDa0l67IjdLJ1aYQ1BXmcfIBzAxXuzIXpD2BPx0BB1CA2FCbMQxselZQoRZ7B4KzscLLQ68u/N/Jky3/w77Umjj3IJIBOHECjHLvrsyYOAon/0+D7NJwUxo6s/002mRtSMEOj0frBaylXjY3mA5EPgdj2UDxrNI8N4QHG5O3km8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMRFP7Y2; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53987d78f0bso1647570e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755083132; x=1755687932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAU+zceNWMs0ZEPv7KyAXNBpYbdpha+WzKllqlveQak=;
        b=eMRFP7Y2BS+7HuyDFtBU37DqWu2ZEhGvg+Y5Eb+mmSRvQ3yuktsTy/HZTcUCrQvfgY
         BjYX4ZlFv77ZLG8Es8l3BhzXg//IF0ar8epgWiXGU0otSXjIiA4jsynspy/gRqZc0MFR
         LE/cfU1UWPWWho0T/Ts2qgxmMBZvrS3zpODzBfh37m7Kjj2CHA+LrqJVfth/58ytYGsU
         VzyPmkwTqBefroTYptYhBCRl9prVhYHCdegovdphURbTSgJk0eAsjUXd5EmX9DPHdEjD
         YRcywuZS0pI05eWWm3INVAYFQt/rVWwU9zznQ14lX3dvO3QZKSQE/njV6+FXLeBIdX7s
         1Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083132; x=1755687932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAU+zceNWMs0ZEPv7KyAXNBpYbdpha+WzKllqlveQak=;
        b=XhMFaFAvAyg/c2aIh7AOnvFzowZvUHeuhLhhDUKsgJRFNgPLYnPgJ5OAe51vMQqfjb
         gNVZMSq1oPtRsxNvPBDYjPVMPigKIxvXewoAIyAFqq768hjeqnZK8cUG5AwxP0BqHPP7
         kOnbACYEnN+LvvlSROG9bHwiGq0H8X9eA0eOIOfIKkiwZqcG3Jdj116uAq8IGD902Bi+
         rpdoJbill8lf7K6/tJGc3Sgrt2sTyJb5q2dewwXKTGVS7geF6n+EbMhSWZaffOSaxOBv
         PkGh4SqeqELqLz9z1Adv/k+cW8Olo+aWER7NY4U6e14vuZaXZJx710oS7V3wlbghBDmO
         YCVg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8JhBCOhlPAfrwnePAFHSm/UaEExA6oIvBbRzF414dQTWyL9jj266uZqMbedRaVEAmFY4sYupdHpa7D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tA4Zo5vfzQGHUBGtf8chvwbVNRuPkG1ScBibldWPRbMwIEJZ
	8k21+rdlYm1k2P5CcFq4QYTtHfUnzTQqobu5oT8pyYSCPcNUfF7Rlqbvy7UJ9nkOeQeG99OY3Zx
	iEnHq+Y2oRMW2ShfXd389QwAvuNzSIRA=
X-Gm-Gg: ASbGncvp789+caYQa/dQrBUW8VIkJZVdxOYaM2n8UyUSTAT4jUrje3xCDWmg7+Y/nbG
	9GNiQVZjZ80V0K/DPlhHXAWXYKRNfbIDNmmWlWyDTWxpemNjoYvhSI6gz0DsocO8kUA2Efqiq6Z
	uSWW/fckNxozDne+PzeAc0Qc+WkX1l4IVtMcV0hNK4IYm8qU+CJ//k05p+tdyW84GxmEmg0kQYI
	CmjV1M=
X-Google-Smtp-Source: AGHT+IFPxhkXOxrLIsxMwcvQ7cx+/7YRdzp55QCPl28lvedTXAyfIC3Z7h91nGDbZFD4Pb5+wy+uQsqY1MuUcTusfak=
X-Received: by 2002:a05:6122:21ab:b0:537:3faf:9b43 with SMTP id
 71dfb90a1353d-53b0b64762bmr691742e0c.12.1755083132012; Wed, 13 Aug 2025
 04:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org> <20250812-swap-scan-list-v3-2-6d73504d267b@kernel.org>
In-Reply-To: <20250812-swap-scan-list-v3-2-6d73504d267b@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 13 Aug 2025 19:05:20 +0800
X-Gm-Features: Ac12FXyVj18wyuBxiQGXPtGH3nYyv9ueaTOPrGF318nRrxEi_35SMElTGl7ouKw
Message-ID: <CAGsJ_4y6NpwggLsmDJuSHNn8EM6Vq3_tS66+iN7PoPgOY7ZhzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: swap.h: Remove deleted field from comments
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 3:11=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> The comment for struct swap_info_struct.lock incorrectly mentions fields
> that have already been deleted from the structure.
>
> Updates the comments to accurately reflect the current struct
> swap_info_struct.
>
> There is no functional change.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

