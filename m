Return-Path: <linux-kernel+bounces-866831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EF7C00C25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5C6C4FD508
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355B25785E;
	Thu, 23 Oct 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEHQSHVc"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7D222564
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219151; cv=none; b=YxUIeBArhtCBUAZzwLZNbnbThhy2tMt7lNsn4AHHT3e1fJp2CgmnSjyMla/BHzKF4d9VfETHhAIfxF/mqAi0VdkGYfEt0YYJpMoHIBuH6DSEvB8djZks9xJLhGlkE8+9mgENu6kebpniBL80reWNvq38FgXgCB18n8ql32D6Op4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219151; c=relaxed/simple;
	bh=hkSHrx3VxUsH7c2KJUXb8xO91/wpQksc9YO3odU5Mcs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MI4upwJEKLnoJvcHS47kZpGKMVlHpG3XijLiaQHi+Pjy6xgSXIYA1sTjFAENBjqeoFa+J276YAgT5c6F8xTYxBtNHcQHZWiCBHvzaCAi2mqVnLGG6mNXP+BZtlAM3P3HmB5YPZfp/uXuvwv825cZaSLoFytMowojF1mIQ5kmtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEHQSHVc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso1412820a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761219148; x=1761823948; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hkSHrx3VxUsH7c2KJUXb8xO91/wpQksc9YO3odU5Mcs=;
        b=GEHQSHVcHz94eQNLThw6g1mnuyM0gO/hONwUA3WNNAsQhPyuUAnIKqLfWsfKoZc7SW
         rbT+bHLmgizD9HYJuU0KG6vzlWje5hSd1HZHpIER7Vh9NsVbimpcq96Wvij8CXffPSGa
         jEUtv31t3oGSVXMH2+oUw86haonl8D6m2ZsIUD3K0Bgb54RDTcaCJ0oJqyRBd03dOxIe
         LXB+YtQjaF58RgigQB1OOaaWHTPbe6CyI/zA65DuABxSP26b53HoSpxSoaJu3KC1lBZL
         zEou4DmP8jUtFVRJq256+pMh3bvq4ufZ1SCkFT320rR8jo9onHd8nnKuwUI5LyqeCZXD
         rTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219148; x=1761823948;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkSHrx3VxUsH7c2KJUXb8xO91/wpQksc9YO3odU5Mcs=;
        b=TQNx5ydrXFnnX/PmWykgwr4/Q/xx44zeI590pVjyhxnTKTZU57A+kG0VagSamYsj4X
         nXAC1l7NpEPox+vDNbZ+YJaRFzUOZeyIQvvUH533uJG3pU0QKgctKRVlai5A/PKSo8Dg
         oKW357y2soUVl5/NhYQ1ZF99MiagvZPQGqFvYlebnw/Ai0daHv6QS7P2LKeptrxAxNBT
         2pnG/lXN2a8ZtsG4SOzpHQUSPtzAV8T+HxXJnj1BBsu0TlQBJhbLQFDKzIgw+X7S21rw
         IMCBS7S9DBwYJtsVqdSVRmRjNsres2iUG+OCKtvbc/uxixAXFO/T4okePyskYctsv+2A
         CbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy5XEfey5zEmBoOlm5to4vzfr3B3EtQg5b7kQ5QnvlnkxSxK7rZaPInQXmKQPcNQ6dpjiNiqdhJL1n8cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVZ7RdKHCt5yfecbgunUE7cIBWkDAFx40v/mWk2D9hHkUd5Ps
	n/ijFcJL+lfM6Vy/MST764f/JV0xG9t6SzwSsIOytEJaJDw0wffiORc8p2/SSxy+
X-Gm-Gg: ASbGncvf8GJrkK0lrA26T6hFZL9PDu/gnqIAcejxXiL89nU525VzLOlLIblZFaw1nHT
	JIUI5Dx5HEIb4SySfcsWqKS1KgNRKStv0uQIYBFKdtbmtAGpqu6gcirPVKFws/v3Pby/upfCq4Z
	3VKQsgJwEHkp7yNGwn6oc369+wvS2DFcIHIJgjUD+8yZIReVyf7LRsRxGpPD2vNuxgoYzuYRjDL
	tkYqKm7E05x14V1cx2q7zd+3oEER/aa2WoLrxLcSRbZ2h0+MpuIfrVNWVjJgyzSGh6vEb8cxiB1
	LnddlU0Vd1hOR8tFTO+bCxZ09W0GjJzE8GzoI0OB71VNBGrM+RDcMphlMj/yQ8rrgx9Cq8axLgi
	F9R+4fUuYBKDkOWWMtntI8oWPe7AUBd5clh8KbxhrW3AkB7ePmL0WtAwPtgJTzLwp2q2Wh6eq3S
	NSlfOirxhbfyoNew==
X-Google-Smtp-Source: AGHT+IHOljlpTe1E08pYu8/z+lSKv01GnF4x5HcsbOYapqVoGC0NDovHk7PceT9YuTHAm2rbC/6Jkw==
X-Received: by 2002:a05:6402:358e:b0:63c:82:619a with SMTP id 4fb4d7f45d1cf-63c1f641c39mr21555954a12.11.1761219148411;
        Thu, 23 Oct 2025 04:32:28 -0700 (PDT)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3eddc3c2sm1469200a12.17.2025.10.23.04.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:32:27 -0700 (PDT)
Message-ID: <43fc4d5ea1ba740517c21d056c7853631a537e6c.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver
 for UFS devices
From: Bean Huo <huobean@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	ulf.hansson@linaro.org, beanhuo@micron.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 Oct 2025 13:32:26 +0200
In-Reply-To: <CAHUa44FGUvEAe-3nQyNejjuUPnG7JjnaYBgvHzwrs6kUnJYWVw@mail.gmail.com>
References: <20251001060805.26462-1-beanhuo@iokpp.de>
	 <20251001060805.26462-4-beanhuo@iokpp.de>
	 <CAHUa44HA0uoXbkKgyvF4Rb9OJa1Qj-Wh7QAmQxXYAf3grLdktw@mail.gmail.com>
	 <893731e9c8e4e74bb0d967ab2e7039e862896dc5.camel@gmail.com>
	 <CAHUa44HdV8FJMayVg6TFz7oGZc1b6QntxMsUN8mdTV7pm7vkKQ@mail.gmail.com>
	 <a040353e95a67dc3bde09b5f3866aa628150c9db.camel@gmail.com>
	 <CAHUa44HYNgiRU5yOrVq8gBwHEEAxGz6TyT0PrBpVOiFfKxYhOQ@mail.gmail.com>
	 <97c39c0cdb6b96d791fe05f8e5496a502a7e6ac6.camel@iokpp.de>
	 <CAHUa44FGUvEAe-3nQyNejjuUPnG7JjnaYBgvHzwrs6kUnJYWVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 17:53 +0200, Jens Wiklander wrote:
> > Hi Jens,
> >=20
> > how about combining wManufacturerID, wManufactureDate, wDeviceVersion,=
=C2=A0
> > Serial
> > Number (in unicode), plus the region number?
>=20
> Sounds good.
>=20
> Cheers,
> Jens

Jens,=20

please check the new version patch v5 I have sent, in which, I addressed yo=
ur
concern.

Kind regards,
Bean

