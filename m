Return-Path: <linux-kernel+bounces-863583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD515BF83AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7C3B66DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA962351FD7;
	Tue, 21 Oct 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJzp5mEe"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C76351FC4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074407; cv=none; b=eMVbnYFY+JxpT/juPdxifcTnzVF+I2Fn+oP/TJslwYsTxqICNP40jm9D8FlU2mxzS9bz9P0cUrkDWQDfphRdLKNQCaZqwG/d62i2eBBuCw8iKB2AaqXpdsAaYhq0FwIpib7JfMFo94nsk3Z++MLyTW4CMxoE7LxhtGhZ1e77tuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074407; c=relaxed/simple;
	bh=XF8lCN147t5Xy+RNN4uA2G5rBZdwuSV7eZQQMLT017w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ut+KQwq/uhyR6rQ05t8085wKNe5et4RUlW8Z1oERsSChKVMQ7bwZkXHC2m+zc5aufCDMscAs68mhzJq0l8bZ1rj0CNgIuzfW+0Fnanm1AhzJKFWy8EHS+eURuvPy1dz/FROgGflgGXXbrIv1dyCDGZ2B5O9PL9jZt20PkRfSdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJzp5mEe; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-591eb980286so1526499e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761074402; x=1761679202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF8lCN147t5Xy+RNN4uA2G5rBZdwuSV7eZQQMLT017w=;
        b=KJzp5mEeYdJzzxlbjsQEUTFlebHJG8X9iqasxhpDiJjOyHQVv8yr6M5jC19Ug90/jF
         8QVJxqseckDiji0y3dB9+X7jsZTWWWCgSW+ZicH+YxC97GT6Aw+CJ4KY9IH2v2RtsznM
         HlQD5njAaUEaRmRk/e99i/t5Qi6Ghu9YlQ07AvI34/W7gy4uTsa17BItBcOUvcU7j5wp
         dh90R6vrw+OHPNcXGEk358SGpOsV0+usztbhfaR7UJWVEL1ieaNlHc6YrAxWc18ia3L1
         erQMtyHcq9805U0nCintbV5EiXyVKfP9OeUccXUUWTsTp/4t5RfpjWIZ9chAKE0JTyng
         BIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074402; x=1761679202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF8lCN147t5Xy+RNN4uA2G5rBZdwuSV7eZQQMLT017w=;
        b=PacUMxxmvexnXS+BVvFs2tzPfTFyyKzZ3x3EfHZ4CaBt5F96PLVdLV7Yvw1WRy7PQM
         TLgCgW4sTyiqV0AYtsJc2gxiwaPv5aBDF1Bq3GdXsuPaGyz/vR+Lx3SaZAUIwd31/eut
         5FaZN8/Ox2h7TA6KQWbNTtQdeRshy9iinw+dRIXGG41k9yOfdoIlEwswblVcq4XoobmD
         PbxPvqbvJQGCvvZEiOZWHpTRgICt6cIcnPx9vQWxx2qb2MVpNMgUrOLqZQ4G3/preG5/
         jN9eantPNsFHpDwbPGKVygzCIcLQgcZwKIjjcNPCEodxJzN0QbuCEDZcC9vUGGV9c0vn
         MRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtMIz68ZF90uFXU9YMFenERy+RzvmQEizhR4KNzpW6xQ/5gCRJ0jfgSPk8yqL5OXfCWW2p+6yclUwMpfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwOp4UROEFTU2QL3SYYwpTPFhbPRPyIqKShHOgi2kIYdqMxWOg
	JFBzA4C4f2i0jmUYQonaU+qejxZw6xom9yfDg8Q7paAlgJ/uFLLY1wUkpaXoB3gDU3ioikK9szE
	0YeqpwmbENaqc7+WWLmmd0Juti+UoWUg=
X-Gm-Gg: ASbGncvbsKU+ixX3vVewhFAxy1ZZd8uG/WoTbdt05UGBS8BXfMo93vVRnh7/FUkO1LI
	ZzKtk6UmG+0g8SarrnhoCcWcTPvVhFL7+zm5GJCXp1ARkpHfEmHzPD91PhN5kXH03VeVwniSXi2
	6dHjkww50vYyBz/B/xO/syhvh8FwilB2nQMykD5q6fglcNlqpKfQhl77S2385R10KjKrGw7Ft6A
	KJULBNu3jkFGyCHbafZfpJVjSqOq+HP8BYwnbdt21lKJapg3VmRmBxwgihP
X-Google-Smtp-Source: AGHT+IHwT8B0R5exz7jadTBxGXmtid9llIfQluzOLS1CeZTO457I56feeO6M9WQOY+sC87UPLBULcwRCSiIfs5oVYqw=
X-Received: by 2002:a05:6512:ac9:b0:57e:6aef:3ffc with SMTP id
 2adb3069b0e04-591d84e3c8emr6604351e87.4.1761074401398; Tue, 21 Oct 2025
 12:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-tegra186-icc-p2-v1-0-39d53bdc9aab@gmail.com> <ee6b80a7-4505-466e-a433-5f186d747945@kernel.org>
In-Reply-To: <ee6b80a7-4505-466e-a433-5f186d747945@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 21 Oct 2025 14:19:49 -0500
X-Gm-Features: AS18NWBtcweEvCq46SenFYFanpeRQLBTS4t1fv5OY1UgDaihsUSCmyvFCcSEBGM
Message-ID: <CALHNRZ9nXYRgjmpbR5KiQpsSf4hu4=qcgoh8F9_5b9yXF_5Btw@mail.gmail.com>
Subject: Re: [PATCH 0/5] memory: tegra: Support EMC dfs on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:11=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 21/10/2025 20:29, Aaron Kling via B4 Relay wrote:
> > This series borrows the concept used on Tegra234 to scale EMC based on
> > CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> > bpmp on those archs does not support bandwidth manager, so the scaling
> > iteself is handled similar to how Tegra124 currently works.
> >
> > This was originally part of a larger series [0], but it was requested t=
o
> > be split into smaller series.
> >
> > [0] https://lore.kernel.org/r/20250909-tegra186-icc-v2-0-09413724e781@g=
mail.com
>
> Please keep correct versioning and changelog in the future. Try yourself:
>
> b4 diff '<20251021-tegra186-icc-p2-v1-0-39d53bdc9aab@gmail.com>'
> Grabbing thread from
> lore.kernel.org/all/20251021-tegra186-icc-p2-v1-0-39d53bdc9aab@gmail.com/=
t.mbox.gz
> ---
> Analyzing 6 messages in the thread
> Could not find lower series to compare against.
>
> I think I emphasized last time how important is to make it readable and
> easy for maintainers.

You said to split it, which I don't see how that means anything other
than 'make new series'. How am I supposed to keep versioning when I
had to make three entirely new series?

Aaron

