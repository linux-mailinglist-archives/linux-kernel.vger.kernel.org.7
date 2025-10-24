Return-Path: <linux-kernel+bounces-868993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B5AC06AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517FA1A61BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66F1F5827;
	Fri, 24 Oct 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pYJ/xef"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651F8405C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315636; cv=none; b=BJ7+xCulBfFJxt0+0Fo0etQhewwM3wmIQE69dIOxmM8d+b366FuXTuk5jrIMm42NO/AXGBfVewCSJtAFHBLG4EXjTJRooCPqUCQf5aPvc+JeOLN5OD5LIn11YxERENd7+ncBsZF1x4oG5x0ztkg+MCrGo6XIwv/DpAOiD9IIvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315636; c=relaxed/simple;
	bh=z7mdjeSNRMzZwFLGQ3nuykuXszU6Y70BSxWt/IzCBb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1SIIL+gpbABZMOZ/cTDyjrme2dE4KDE+ISd45sDmol44w3dykRfhqoq1z1yyTBWQvR0s/cbap3Ad2CSgZF41ERCXHve/5ae+GEx2WauRWVGB0luB/3DrJjC00Du7IO4ouG7SAgBhTbOSw2o4tTNdoqFZ5lJu4Bj8UjwcAWRQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pYJ/xef; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-592efe88994so6331e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761315633; x=1761920433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7mdjeSNRMzZwFLGQ3nuykuXszU6Y70BSxWt/IzCBb4=;
        b=1pYJ/xefvKpapFRhQ7JTds7kdxuWrHoO/vsm6VL1I8kIwFDxANSfpgd7ZNd/nPJprB
         VS7BMakfLhLOLbU91hLYCDB6DmkPfjrn0E0Sh+4XZ3hJPDg6o1zLt0aCESUoe92+QAou
         wKqOGqgYYqrN3Kl4qYzjqSKLfDqoCJxyvS6r/NDkVf8AM/zRLOxfLv6BU4ElGtwXOlsS
         O5DQgfIUwKD7sMZab7CuRpurRQoNw9kWn+dFEO1QgdwiC+m4L2zD99Nn+xSKsSBpzqRr
         Pf2sxMfsznVIl4bsivrjdke63Qp1lVJ5iinc39IoknzIbNf/bU0Ew+GLpGh9Is5hfIWZ
         K92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315633; x=1761920433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7mdjeSNRMzZwFLGQ3nuykuXszU6Y70BSxWt/IzCBb4=;
        b=BEj6fNE8Bi/ftxaS3KtzB2NloJEfkYkntMB+ADyqqJ240px7p+jIM0At/6ltAJDLBW
         tlIxhrtnOHQchkX1TQ4UfiZS9Tokj3YG2Oxxo5dqQEPtk2UQHORbG1oZ1Op9V599TR+8
         6MGGsrSm69vXP9O8AZPzrkKUhj+Mt43PRhYDdQ465WSmICNsLhxqrQgjLV2HbjbtkxcA
         Fp3TGEUr6dIVn8Ts9bgj8rtNof+sCTyHo1z1NH9v+s9F4AKFWsVqX7D9cBlOSxhh5mMD
         6JDpDIB9V/ZE1gjPfNdHqB/adVlC0vG6bkfoXctIv4/ysgCn38SXolwR7MQxGPZhNNsg
         mVtg==
X-Forwarded-Encrypted: i=1; AJvYcCWm8q4XFu3KuriTP3FA9E6+9KdDV9azmQ2GYkoOSLILfZPehtoH4HKmx8pHaCxFl/l8hqSDBeCxyZzOAfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl229acuXRZDZauXgThm6hYBnURI0MGX/1U32KJQ6AyJElbeTG
	2LKBgMezvgBWDQoCiZI53iRGGu8FTaFcDsL+idCi9jIkggRlfz0oi2VegamfZtmTl39xnDi3IAl
	7i+SmjtiHPWmqV96YeNvzXGW2TBx+zoJJ+tkVBdOx
X-Gm-Gg: ASbGncv8bWZn1GTWxguYMr7e9eb4XEuThxxu6jeM3l+r05bmr4NnWuzSudpnhsHwoNj
	u2TsV5CK/KCyDG+TJMLCqEyx3LSp5ID8LsnBPdVkMesarPcFJ40NZqkVFsIiZuYOvhacNTw6hvI
	lUyxKGlBD1LT67C61AKy+seyjt+ZEqTpICZBFpQvdDAMIorI9LvWVt4GnRS6pVx5L5dB7dm6yTr
	I6KWNHJggB1aECARy+xjP5BsyBy5J3EY7AEsSTHzkwetBv6z3iURqqERCI4sGohE9hx9hLROs8E
	mS9umdqZcyUjEc6fpRICgPU9gzIW
X-Google-Smtp-Source: AGHT+IFxlufZRk894FXWiVQLtDurWXJ665jIlvBcr5MuVgdWiua2ir06pFSuWEd4pNbvj8X55Y3qVw7kofkstr9vCn4=
X-Received: by 2002:ac2:5f0b:0:b0:592:ee58:60a4 with SMTP id
 2adb3069b0e04-592fb709440mr292087e87.0.1761315632854; Fri, 24 Oct 2025
 07:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001022309.277238-1-chao.gao@intel.com> <20251001022309.277238-2-chao.gao@intel.com>
In-Reply-To: <20251001022309.277238-2-chao.gao@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 24 Oct 2025 07:20:18 -0700
X-Gm-Features: AS18NWBslZ-Q0nUGmswxtdkKQ6O5L9Eu7WfcDcZMdwU6h0y4vDuU8qnl7W3lDMU
Message-ID: <CAGtprH8eXwi-TcH2+-Fo5YdbEwGmgLBh9ggcDvd6N=bsKEJ_WQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 7:24=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> Each TDX module is associated with a version in the x.y.z format, where x
> represents the major version, y the minor version, and z the update
> version. Knowing the running TDX module version is valuable for bug
> reporting and debugging.
>
> Retrieve the TDX module version using the existing metadata reading
> interface, in preparation for exposing it to userspace via sysfs.
>

In addition to exposing the TDX module version via sysfs, it would be
helpful to have the TDX module version captured in dmesg logs/console.

