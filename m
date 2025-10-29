Return-Path: <linux-kernel+bounces-875369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAEC18CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB44008B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CA31076A;
	Wed, 29 Oct 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR1w2pes"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368B30F94D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724357; cv=none; b=h/wV5d2U+TlB1mBpHHhV6Ail/hsMVAp/hRvn/EXDbTkCYopHaR0Se/yUrpvDZllOoJAwB1RFRRNY1P4dQ359BDZVAeS7cPqEBcQBMvnnaPwv8TOAaAaa+heSHfGtVHdhNPGUXjP1upz27LaNNMFmNoyWLCQmzJ4su5F4e6gyDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724357; c=relaxed/simple;
	bh=d+3F8ifPRHXFbWiCU0mXGYHLj7wBVR6XNBd6P3QTX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjlR+v6fcFQXNtmtR1qDr8zYNRrq5gbMq5IUfu4RupS4keNVV8SO5so0pwiVHytm9h8NvT7zBVDWb7yYOshlEXDhOjN0cQhyJiGLoKQK3Ihj6uQKvWAFfRvh3JHuPpH1IV5UwYyNmDvdu3P76wX906TTcY9vlGU5OIwuJ25q98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR1w2pes; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5a8184144dso1085566466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724354; x=1762329154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=KR1w2pesO82Pos8i6pVakPIU2Ju7r+z/lQWWaNwG3VE1qXU+DlQjKvSevc7krHnlB2
         Z6Y8pM0EjcVcuYLttLENggrIYO+50ULTHbX/fBh0zvmVIdhbs+BRq0foCqIzwAg/hk/C
         vMR6lYkATzJD6WMxgUXtPSXrweyKTDtzj/E3/kAS5OL9ORjCnVSW4Za94+FESuKtiILG
         dD9QnX8VQDJSL/j15xbyIw62HH5kWs1NLUk0jxyUtMdAR33G/iZe8YrXBcERUs2pDtWT
         CuBraA6gRrDIyeoprzOXcGqDXuTtj0pHU58AeesgJE7gGIhOb743FxAsXh4VuqIcy9Vh
         hX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724354; x=1762329154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=Qb1Ew7tXie3Ke3EU+/QzpJWmOD0iU7FP2fX9tjgZ7mYu4ZKtdXCukDyszwcTjA+sVm
         Io4+mgDoPOg9AbWrUAQ5GjxQo5MgKNh+csDpWft3U3rULzBkLA1tNj/pnJFA9F7KzIP4
         1G+xwfvpCZ2IF4Zo1hzZoIJYlDIDi1F/FTtrY6i5Jd4mVLHD2Jox8C/XOy7j5jHx6Zmg
         FzGv+TGtErgtl2xAXuedibvL+WQDunoBWbM4wX6uydBhzpD7SuI7+Dn5x1UzObAqIhrY
         Xm03UiunZKCuhXVlzdAVLe3iVZqeBySIG4BKXedUKCitI0r3qMo6lLJNwe6RyTaoHctC
         b9ig==
X-Forwarded-Encrypted: i=1; AJvYcCVz/N+t/VXjn9qPVMTHXHtIIML4MTqlliV/YwvJYnDcBgBx4UOhP9uH0rklfeefSNNOcRM36oHnnMvWvj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMShcLfNMcy+Li4KPiaILzjRCNBA8h7sZA8zZxbtYaiv0U/NO6
	h8NekaMqyFpR/KhjRRFJnBLZbh3TTEbP5T/tI1+yHkZ0st4E50aK/Aeq
X-Gm-Gg: ASbGncs1MBvwvAYzdHDQ0XB3gvYzsfZj9HmX8ALCW+Zh9+QYRwcdQMJPaFBGz8LNa3c
	aQvBFY/P0XMSrcBfOUcGGHf9oyT5zrH6rRIlTY96G2yrNoaqxxLOSuINMisPbUteCqLYPFLc1fn
	oSXPC6xn608cLDomr6qyRv0YAzJXpUFAvMuon3Bvpax8KRpcR0ZMiBuz5UYDSYhnJW/p2DBG3GZ
	ohncyv0+EyVXL3yL0ohoFgS0iiXXaVdAYnT/CViZVvkbRybcePLH9MmAAVLA/EW6gOZ/NAZrLXX
	yjIUqC+z4vVUedcsGR/jm9oefQVb1HMZlIXsREvKiFEkDufaKkBOVkgr2gn6r2IaUunO/JxVbUK
	7E+u/pE/h3yZtCiSQOPmIH/2X4aJD/iICTyWiMMkpYh2jEx7jJ9hTHG1WIukV7y9AfqK37I2htW
	7g
X-Google-Smtp-Source: AGHT+IHtSgmrBsC3MRR28mflYTkgpLevXtnHQXIDSUigDzjREnxXOwaBD8WEsWGS3KPcLidmHJbHaA==
X-Received: by 2002:a17:907:971f:b0:b5b:2c82:7dc6 with SMTP id a640c23a62f3a-b703d4f7df3mr180499066b.40.1761724353666;
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d85445d48sm1331864766b.65.2025.10.29.00.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jannh@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@yhndnzj.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Date: Wed, 29 Oct 2025 10:52:26 +0300
Message-ID: <20251029075226.2330625-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> 2. Incomplete - misses inactive namespaces that aren't attached to any
>    running process but are kept alive by file descriptors, bind mounts,
>    or parent namespace references

I don't like word "inactive" here. As well as I understand, it is used in
a sense, which is different from later:

> (3) Visibility:
>     - Only "active" namespaces are listed

-- 
Askar Safin

