Return-Path: <linux-kernel+bounces-892730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB3C45B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AD13B701F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EFC3009C3;
	Mon, 10 Nov 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eXjTAfXV"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF4231842
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767810; cv=none; b=dnLhz9WcKqOs+rDXBRGvYzPyJQNnu+lZiqggTpue1eUhiKzHwBan/odHdiLvfw3x3ziuGx3dXiMmyliqco0Dw9x/jKldi7LwONTR3aMexkiD1NMg62Mdx6Y2huLVDtlk2bpZa0tKaJ3IiCXGV7ujrZ0lCJwjvieQcAGWQMHoS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767810; c=relaxed/simple;
	bh=VQ6/fZmPrvB7qA6vpno+guzDiFQYAH2t03L/Ew0dBIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoM6q7d1OLjynVwoZHNyQnfdkYe8FPO+3F/55DBe9EXHbFccM1IIJAzN8BX0/csSAa7VXN1vmWQ9ooRpLzQA5NLEHqvzUk8ZM5cVZvuAwZ/enpWFkT030FawWX0ZRZKPlFExB232FnHWc8+Eniz9CAsBpwtjDj8cbJNOqIIhLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eXjTAfXV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5942b58ac81so2180956e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767807; x=1763372607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpfkUQML/MBOUs+dxtMBj7gJeTOySOYgrh9cTXWXGS8=;
        b=eXjTAfXVwZ/prQTUAcg0AN950gIC0w1tqjmWWy2X0z7ti294XrUXb4d3wbyXggSM6h
         pWk6SIYEpXf5bjoAPD9FMuTkc/F70WpzVMk8XzikJpxwr06hhlVbHG4R5YT/2Al97T/g
         acCHAmhvtB0tor96zeQCwfvBZDEKpd+YY3xKQJcjypnagYNMHMGz5P/BYgtRPisyU8d6
         Oad/rdkhJOjaC4DmqylB0O/cePI0CB8KiHiQdjWX708FHXInLoxA4FFB56JVp4pfg24e
         V99bX/X11NihIifdrgL3QWPh7z+SINKYeaHPLjGgbzWliEhWA67Szw1VixNibjDWhE0V
         b1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767807; x=1763372607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NpfkUQML/MBOUs+dxtMBj7gJeTOySOYgrh9cTXWXGS8=;
        b=Z6JpIIxMMPOHyFON+2QWjAvFZYMMvVs6qId63gojg0shTr/OqM+oXPJUGO8BvAPPK7
         pvtmXGUrgsY4V+vtj38+Kcs3o97uzOoijYYryXX4Onq0MwnjzLlRRQRWo54ABomPuptz
         cKYn5quvH1v2MzQmfN8hQ9w66Iziu34A0iD0A6qUw5eSjGKrgJb2j9JKMv2pVRNriLDF
         2t2m2vpVwggltGkHBoidJodQNXsiSiDZxcicgeB20cM6OxEgKJy/xmsIZUPnq5/AQnQR
         6sgFJgwZXW5vg2UUMMxGO1IdRqNfJe2wFZtDWbaUhixn32w1DxNLMZLgs7OrXca0sjZD
         269g==
X-Gm-Message-State: AOJu0YxIRQ+BEkS+i+34TyVm/XNf6MwjR9dG3rwiCrkBqkIgWLH9XCoD
	B9kT1USb9m5OejfYiH6b7BelIDsqXCy004SBTc4ZdVi8h7ZGfabGNipq1rV/p96FY8Rif1z7DFw
	zldpwaUx7HmoN9c9IG5bEcXwd2nJp6KVUVpLEB85m7g==
X-Gm-Gg: ASbGncvo/vWtEHpGziD/BM+jttQotIVFrsKC+xjXYA+9hMz1L7heVnjU+Kdppf2+Grz
	XenjF4ttCFwDTvJvYbC22u6VVL3K/pQcW7hKcbTANC0athBZqnmepTmZnD4lbB0jYDw2pOU3TtC
	uC9eRkySxj+fdvahTrFawNplQXdTT4MEWeobxl3kGF/2sj7AsL4s+WxO0CXzFw0tZcLGDS4lEtg
	UxK6vmT+9gxjS4LIkwt63Jb+1eutFNScptcqmmelHW38IBIYhodBQDi26eoQSdjZ9pfyMIzD6ah
	AgRziufINggNydV/boCB6DPImVZZ
X-Google-Smtp-Source: AGHT+IHgQciVPQpfcLaTr7J1ezPo0RXgw/svQahgRjh6TaxhfoSliPU4qSC9XOOY2ROeQugwrfeNkmq+pV7jc15hMK8=
X-Received: by 2002:a05:6512:23a6:b0:594:5206:c1e2 with SMTP id
 2adb3069b0e04-5945f1fcbedmr2111007e87.57.1762767806714; Mon, 10 Nov 2025
 01:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106162430.328701-1-marco.crivellari@suse.com> <176275881845.11063.4284661115624687.b4-ty@oss.qualcomm.com>
In-Reply-To: <176275881845.11063.4284661115624687.b4-ty@oss.qualcomm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 10:43:15 +0100
X-Gm-Features: AWmQ_bm3FNiy763e6HxI-D87P1o2nsjy8IiM1WAZisUGNsfLYyFUSc-C91tcc10
Message-ID: <CAAofZF4kvMqf-DfahwY3sSKZn-rHcB_Gf7mVqDB0fBptgOA=fw@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: ep: add WQ_PERCPU to alloc_workqueue users
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:13=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> [...]
>
> Applied, thanks!
>
> [1/1] bus: mhi: ep: add WQ_PERCPU to alloc_workqueue users
>       commit: 9e24bdfecdb071a3a42fb74be1ab503c958e2740
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

