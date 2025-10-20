Return-Path: <linux-kernel+bounces-861731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4553BF37FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74A3E4F3973
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6672E3387;
	Mon, 20 Oct 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUGiufY8"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC472D63FF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993476; cv=none; b=lfdwNhk+32dqaYGNOhzDtrkGQuFCcRlmro6yb1usqRSCfPx/Xv9pkrRw2f98sejOpePQMKQ77d0h+mcJqUvIDm1ISwBY4NmtxlTwfQlbh0O6diW6YjP6vC2/tT8YSOwy/OuWggckjyslNz/0jr2yQA1E1aWA9Lt0kp7FvQ353l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993476; c=relaxed/simple;
	bh=d/DNocr10We9+tRibfaGdS7+LWNCjniYedbAm0aObrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2ZmgxENl/WrdZwc1aRBgpGpduynwO8j/fpb7RD3Ew0hbqNcu4CByIVSyWnIoUoULH47LhfC65OiVH/IqZ9dcX60/QEIcvPOC+vOUNNcQxEc4QDBIp6lCJr1HPw2iFQyxY8vxt3xNFb4BIP5VL5qgP8NBjK8nr48CDZqF9qXJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUGiufY8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-579d7104c37so6047210e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760993473; x=1761598273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/DNocr10We9+tRibfaGdS7+LWNCjniYedbAm0aObrM=;
        b=FUGiufY83yAlygBhP4TFTjFNKd4/t2agmvIzik+ZTYI9pDcxMgppvelmm6v6+YdXk7
         hUkmPBIu99umbqZrqqNdT+rCkDffaSnuAcGjKwG2B/TryDqmvTPWAkdm6IKExPqInpzW
         Z7o5BKrwzSKavjm6Qb0GY29CwMids43H+cEGDWZlhHx0negGtFLCUTjuP5DHtA3KyTzg
         f4GD2XF7CpyLvrI1rXhqFcWkFAwafWYXd7b9WebJ6/vHG0YmsW1ynh7H160kVZkB1i5U
         l/zLciJkGsQ1EJqPZeczG2YQypSE9HTmRK2REJmlut/FJEn38uwGTEJrF9MivwqsGRCU
         NWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993473; x=1761598273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/DNocr10We9+tRibfaGdS7+LWNCjniYedbAm0aObrM=;
        b=l8BBE/mKbzCPbSBP9XWNUx+e7DxQskUQLjZbKIpQgLXQPErMU/3ZSJSdnePZCY7N7Q
         zwdxH7hkh/duARJzsSj7qNf5VUQD3mT4bgj8ko97+tJSrflhTmJ+gJV/bAPzqUMpjHNW
         gDGr5PuyUMc3kYQxvc+tgruVOWTeFYIOGGRZpYy5pdrzEjHD6xQyBsil/OyAnPiQ0Wfi
         4bzetJsF39GsRCogBJeapJJjctRJ6TbPMPRxErgMBf8GvV5OcntOczGEGRrwopoW6+aP
         /AylxaHGZuLhW+ZCEfLYPksYFJffxQNb5wDxHQA4MfEXEm4PPjqq8wfsqaebCkMlZeBK
         9H/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTHh+GxpDM5NWrXlfrBLzS3YZeKP9fsjqxfDIP7bj/QzII55WsKtD3PXbZlQ0i4OFpt/t/XO7OeLsklLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLmhlgV5lS7XSOQrvYbZAOT9tD8Ij5L2MAxujCWI89Nl4/hrZ
	q+W7qlbGLQMX+hYaA5P/KbyZG62Jd73fJEQXhar6PuCQTQ0IyXpzWjzR19zsqOSI9vtw9EIaOUt
	TEXerkA37Fydd3c7kPJs9fV6qTsO/cnzDWZWufu9r
X-Gm-Gg: ASbGncvVxVuYM+3kaGSR8uXYBGX7aO6PxIU3J0cMGlqrWWzkEQ+anQH8x/XaWv09hYQ
	+eJ9gd7NTAHy4ZKDvDaCcW/nXLlwbLhlH1bBPXF9fU4SNIXZ19HG2grXExfN2xtD34RowbYzWmq
	ywnU+keMtI34X5NuKujietbHLHL0/Im2O1g2expZhJ5mwbe1SpGAOLzrFPhmmCKLA6kReBjwzGX
	FhR3ONIAWC/Ka/7tK2cBZRcuPY2mZvlIPkbQa6K2XlatiXZlxlfj9uuY5xwFQPi3yNJ1DFhKqBJ
	6fVglWo=
X-Google-Smtp-Source: AGHT+IFptH7lgeIQIF8Wb79g6w5+VZiUQoWjQkKuVLjC5A13jG0UM4rCDEn9XOnf7H7IQFGgZlhwFcy9kFCumyNbmPY=
X-Received: by 2002:a05:6512:3082:b0:58b:63:81cf with SMTP id
 2adb3069b0e04-591d8579843mr4495565e87.55.1760993473069; Mon, 20 Oct 2025
 13:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-19-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-19-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Oct 2025 13:50:45 -0700
X-Gm-Features: AS18NWDGxqhjIaoTQRNUFc91_bCzfrzvv4w3uLlEfEEIlUZmI_rVPec29OqIzHg
Message-ID: <CALzav=cD4WLKX0roP8mvWEO1dhLGLtopeLTmH=f-DeV2Z3mAJA@mail.gmail.com>
Subject: Re: [RFC PATCH 18/21] vfio: selftests: Build liveupdate library in
 VFIO selftests
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:

> +TEST_GEN_ALL_PROGS :=3D $(TEST_GEN_PROGS)
> +TEST_GEN_ALL_PROGS +=3D $(TEST_GEN_PROGS_EXTENDED)

The TEST_GEN_PROGS_EXTENDED support should go in the commit that first
needs them, or in their own commit.

