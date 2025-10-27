Return-Path: <linux-kernel+bounces-872637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2FC11A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183B04E566D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E432ABEC;
	Mon, 27 Oct 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mcFFAINK"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9852F99BE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603217; cv=none; b=ai7kqwfItpeoviaW51o+AFYFbaUUy3rok0BPb4GzZgtT15/9J7wT56v0sPAXP0nalBF4QIpypEUX7i2Tnm7Vtw/lfrwNB8poPGC5ELysJP7wPh6N2IK4XdupooWJjwADq8eULznXCi9NPCByQVphztkD6v+7lC+KCJlRHGiCyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603217; c=relaxed/simple;
	bh=mQTKJScatLYjbszW8Nmlz+tuTFmWhnW9yYaJmefda44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnbXrBIwd2YwWMs8Hu0ziZqG/N2hWBwCJILogEEcwXg3eQ0XT+N53SJmXkOh9D7gxgap24Hnrls3aA6c6JXn5o8amj/Jt/3suLlrzclO4merHqUoOESLn5ruHJm7SUzR2R1HbwIZcEZcKe+gYM3GO8HfUAVTRYyQoeZsIBfCt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mcFFAINK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-591c9934e0cso7492727e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603214; x=1762208014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQTKJScatLYjbszW8Nmlz+tuTFmWhnW9yYaJmefda44=;
        b=mcFFAINKBKl1oFJOdmUNYBj3q0Z1Yl5W5xNtzDyJBzoffk0hginF+vLPh24NCDWDwE
         7BW7Sz5S5UAt0c3nr/huh+Npyudh+fU6MefMLr4HCsZmSggcy3zfdqUq7cy9kvBAZYXc
         +VlhYJsFznVt4mNLVehv19PGbi5dt2QiT2rhQP/+vSmY61MBGhaI41xV/+N/ZG9b/4pD
         Red9o0IXhGjODfW5KXfvdowtp6RDKPmLTHUkxdFkktAMo7+TZQOjFXFqaA4w43rB5HvE
         2cJIEN+ccBR5x6Dbxy46Dj9zwwaAif+dLSlsGdGOSM9kisYlKYnctm9/CuKD83KP0v7M
         lYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603214; x=1762208014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQTKJScatLYjbszW8Nmlz+tuTFmWhnW9yYaJmefda44=;
        b=e//cnn1FWnrsgc6Mn4K6Qlb7hPqwuP9g1/8eT2CX7PUoFBDNG6eeAD3sONXqYXuA0o
         HygmpCUM7v/G1VsbKsu3HZOxokN2BWe1sRvcJgrjPjGHXcvEMdi/WrWYJMmn71Wa1nr4
         a8SPf4jH9Ohe5hrIkRsFfHq9BDtEU/5s+9mDQBJEtqzPGxeqbn9gabT+IJuxbbjNxZAX
         KPSR4zWdPWySu/Xk2JWAyXJAUPgjqmzLbaMyn295LGe8oxotNh1bm3MssAtOULhaBi0s
         q9pGvggbKR2aC37a4bfbkxGwf8iVpbcSSqmqOha5/8xtiRatnpYb0vkKAK7HiK1i5PL/
         NO/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfEWAnkleFdtUpWrChUJGSo1TL8GNjqX3LoOa3RuiFpLpZhORX8idSMfe0jKSRNLMs3C1jUm/AxpvaAK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1oNjVGRFWR6dnX0YC9R3AcA+Dkpt/qs6A50m4B/6rQf0XqgA
	rIiPTkvyfxdOskzHoVngn/TvUYLuXIwTn+Dil5NwBLPr7U7aiWQV/HR8MOYr/qAOB3xpaQjmZrt
	ky7NodmDYOH8lqTIVIb24LcbJ0mNpXkG1rRohAEemXQ==
X-Gm-Gg: ASbGnctICp+6YQ9wZNkWx0kBQyKpjxrC7aQKkNiTn9ZpzvNESIA61CIErtcSdYjxJd5
	gAi0m/PaB+2G9AisWylMoORHcR2eSyq1p1dg5+qGgntbf7AQr2PBntLjWL8Z7mLe1nF3vjwO5T5
	7B47BW4uIMHLiaBQQm6NX+BWUN3BD+3kl1ia+uzB6NGnh9sVg68MwgBCMGyjLjhK9Rza3jilLo8
	Kkw/fCXrif53seZPuWMgLtKhMZINaZy0P6jw+SS83OHlwZZRZFqkj1VC1bX0GhmMixdXbc9YOBj
	NUeTow==
X-Google-Smtp-Source: AGHT+IGiyuhAd/g3j8DFK8VW5m7bOjesol+1DXV+h5pePcwa0TlxwvPOrfmVLR7Li8szmQf8I82fLHqa33iH+2F8eRE=
X-Received: by 2002:a05:6512:ea1:b0:586:8a68:9c4d with SMTP id
 2adb3069b0e04-5930e9dd17cmr516262e87.52.1761603214129; Mon, 27 Oct 2025
 15:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-8-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-8-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:13:23 +0100
X-Gm-Features: AWmQ_bnPVCXY1Dpjano01hZ_Z8pqJmAtt3_jZEXugTZ4oHs4-VjsvtZbv--6EHg
Message-ID: <CACRpkda1d+WquYsUq-ntWRC0J37w6=UBcSSAwL_nroS4_h_dZw@mail.gmail.com>
Subject: Re: [PATCH v4 07/12] pinctrl: stm32: Drop useless spinlock save and restore
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:27=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> There is no need to acquire a spinlock to only read a register for
> debugfs reporting.
> Drop such useless spinlock save and restore.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

