Return-Path: <linux-kernel+bounces-741245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807DFB0E1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72D43A87E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC557242914;
	Tue, 22 Jul 2025 16:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/TbqYft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28020CCDC;
	Tue, 22 Jul 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201958; cv=none; b=fFj3c9kva2NXYLIK/qY98BboSWWvRhvEMTFvY49tHN0NWhEWyq9f+r8HoQxm0l8B+cTWrsXDnyo0ELiWavRo6A3qTiuzbqaF460giOwmUwFvKNuedffs3e3VNfH26R3IoqwurdN8ILzcXl9v62vdbll7CMC1LljbYuauibtvgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201958; c=relaxed/simple;
	bh=5VD5cDKyRTDctQiUs+WkrbH3QLqnv7mOwR2QHGRhog4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oByVZN6dyBJ6sf9hPRWwOB2hDOX9GEcvayF5RjVOMQTqz91pqmV+wxVrUFxYKmsbqDIGpdcyCZl9g6FwyhIyfPOLk44I3RZttNFZoB9V3g/1vJpTT5uAa7a0IlfWF0uGlfFhIC+xGBFhJlDRXRoAd5jkjEQN8wdDipTnNeHPpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/TbqYft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5318C4CEEB;
	Tue, 22 Jul 2025 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201955;
	bh=5VD5cDKyRTDctQiUs+WkrbH3QLqnv7mOwR2QHGRhog4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V/TbqYftykloTh2bUPjIuXupDBI6PTFGIkG+VYgv5FQJnhwlmL087LTSfjEOLMlL1
	 UTaKqBC4WeiX/RvCLDgYcl+URSDC4vrbWq/FZxHVJZkb21E8k1pIUwVFviFnoT2+oq
	 p5ZfYpHYQOluJlwQEmCeqbQyM4aRWMIWrRerXv9ZQlv+RSnBoBSc0EW52seUrR97Cq
	 ebuTjI9+mLqI1CWpyOlmJzYuSv+JigypIAjj2OLnuraDMh5xN8wd9yIZu3ZnGB5tA7
	 fa99Y/H6GUz+olfZFjPYFsU9NHZMWzU1fd/d40UOPL2cdWjX/ZEqmVWZMhhABofsi6
	 wTNBq+FIFFS2A==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0c4945c76so773396066b.3;
        Tue, 22 Jul 2025 09:32:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUa83tJ2c4agd9/c3cgenXVXbPKFdNXFJAt+OtnR+zLAqYH8UQca8aAdUE2PG5U9IC7ObqsGs0dkHM@vger.kernel.org, AJvYcCXXdMWnOzWwNllmX38dCOmJJ+KEPHbR9lhPLTbWBQnOMu5cKoyeQTJAfvvhEoZk2DsyvMWwfdUo0zNnVV14@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZcaxbr8bQqCjK/3M6RmgaN6KOILZbX3s9SZevGdnUoBxcTex
	Ip0jr1frrTBCBwuZ4AW0dZgiTyQ4MWs/En3iImxl8Gu9RjEgdKntuwzFDCu16M0UuO6sJqvHcV/
	8RxIuxoNrNNjBi+EOdIskzlEtvaRkbg==
X-Google-Smtp-Source: AGHT+IFedQC2KkA9V8OFrvVFS5ZdEgjGD54xoCF0+NSBjrJ5HqpDkX7EoPPFEz3PSfwJ2JmxH+g9tRdXAosALL4gmas=
X-Received: by 2002:a17:907:2da7:b0:aec:f8bb:abeb with SMTP id
 a640c23a62f3a-aecf8bbaefemr1501206266b.42.1753201954257; Tue, 22 Jul 2025
 09:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721201625.233750-1-xunil@tahomasoft.com>
In-Reply-To: <20250721201625.233750-1-xunil@tahomasoft.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Jul 2025 11:32:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ3w-UDSrxC-TJG1e-0cE8zGTucCZ2UrpPnnt-i3jV1WQ@mail.gmail.com>
X-Gm-Features: Ac12FXygKDpSX9VlkKrVQ5eehBFUyEHacDdAWrNyCzutyTh87Y5nRrHEPN7hOeM
Message-ID: <CAL_JsqJ3w-UDSrxC-TJG1e-0cE8zGTucCZ2UrpPnnt-i3jV1WQ@mail.gmail.com>
Subject: Re: [PATCH 0/2 v2a]: New board support,LinkStar-H68k-1432v1 (RK3568)
To: Erik Beck <xunil@tahomasoft.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:16=E2=80=AFPM Erik Beck <xunil@tahomasoft.com> wr=
ote:
>
> ** Resending with proper patch sequence numbers **
> -- version 2a

That's creative. Version numbers are 1, 2, 3, 4,... That's all. Don't
resend just for that.

Rob

