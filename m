Return-Path: <linux-kernel+bounces-890141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC94C3F506
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 815794EDC07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125F01A0BF3;
	Fri,  7 Nov 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlTw2xuf"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDE3019BB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509959; cv=none; b=dC5yKP4DgFcgZIPPMrVMvMhhMTuuVCo8KNwQ1z8qckBBF+YPYGbH8WHn22hauvWRXn0bNdKQMv/M+QLnpaxfLifhLykjLtHfHNLYNM5TTzsqYxuMd+GnHlHhSN2+79imJDA3Ct+qUdN60Xry3gvEkq0A0smUwZL7f4ebnp06JRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509959; c=relaxed/simple;
	bh=wlgwRJif/bPNXIJtp6p6Md68ujm/+iD14HvBkWngO1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mznp5X5EXvtyZVgxPNuLamdJlgn3pe43POcTVNXZ9qCBdE6cEXKAA84WLgtlsiXvYjECfQsYn01VyIQWulwaQkCBoaChNA8oCoZ1SsvCIdThr5DCeKkGZB6XHvgZW9nsmwg7lHHLUQUeMf1GIFzkMAT+fc6zeSbKWBZHRdGWPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlTw2xuf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e9d633b78so102474466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762509956; x=1763114756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlgwRJif/bPNXIJtp6p6Md68ujm/+iD14HvBkWngO1A=;
        b=BlTw2xufFrrxx7w/rXoGXXDzpLQyoKmij9gcnn83MiZ43uWfEoIO9fY3we4n4q/DPJ
         FviMBZ+7N0jfKK7zDVXQsTv22C5Vx9Jm9i1Eqn2sCgigrwV5DE019oIYGK51fIKQOOzp
         N9dPhVU9MVgyg8dbTNolQsvEM1HvooYqXwMVUlwd6Cih2g5r4BVGJ0kJJADmFf5tdpdQ
         xZEDqJoCg+ebkNA76UBRmhtgnsfx14LHxWidQgzbvnZ3no9kCuXLdUipcLTRC6GOt0jZ
         vKD+bL7ZxNt22MlEwHe83N9TMdLLUg1YP11djX5qn728lnZ+6M2HNOprcKxxpZiMjvV0
         Klvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509956; x=1763114756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wlgwRJif/bPNXIJtp6p6Md68ujm/+iD14HvBkWngO1A=;
        b=mJVFHnx4f+KkWg5HAMoTvoPIZ+sPAdZD9jESViu73M0/67zJx3WvE+j4ZaMfaLsaR9
         q2kIi8/bR85rbpdYE05FyqRWXJ7sfL0md8Lxf9ysa6nonm7r0fU3svdgKVGTewC/EQz8
         zOkRiurSPLK0uT76GjiJQDWzuYkzEKgQLuQNyOqZICHUvurW7qnX/cW/AyYx2WCmciLi
         RVfOdcENZYbN1xLmlzWR0SsG3y8kqk0veFts+IJgGzDXtYD3xNdTHOibZFrn+ZAPyvdw
         SLwA6V4V8MdyV/9XOhsKxXGUuu0+Egg9hnkyTXCZar3rz5bq8T8NlaExrHhQx0+eUSC3
         gL4w==
X-Forwarded-Encrypted: i=1; AJvYcCWvh/UMm8tQHRDscieN3ZIdfjG+YGTrPmydnliaoE00hmff+lUNI5iY8vKemQrduKWBb+e4SWUjEjAZLOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxKbk7/lSI27VYgfrcEbTxm5tao6KcnBlTYDPh6/QZOIsXwQ7
	5GVXHczAlT0KUkDv2SjAHVRoPITKO3z5nbIMaQJ6h4iwMj6i4aVFuKQo
X-Gm-Gg: ASbGncuhiaQHBnaNYsCzodbNG0V1RYDhLYSfvcgq/ugd+ikb1t7PaIqEx0ctskFVMDQ
	vTgcvAZbFzLZ3sjl8C+HVxAjkKOV8VmuOe40Uw//me9Z7WpG3ckqwM3XLwf53bxMrbR4kOlAnrm
	flliBpKmwWVkLN/yoLXOO4l3U152W3z+WRSEcONaTAnQSQ0rJ1Tty6b2dbLgqeVkxQpErOxnxsM
	SVU3hUZ5Gt2CcdBXWCQl0J/gWaZZ/kh4qrvAo6Fu/b/rxkpVKMyVLwbM1lS1t0u0swrfxtNSncz
	4xTKo+at1vzJnoCYsFFGJqXgQJrF018B/qivIrZ1Hgc0sb+SP6ZDdjq48e5wx4AfpwFtqxl4UfK
	lMN+OiXP3xdwYN5km/iEF6PQj+4pqCSDAp1Cm0zVajU+oajoDBuPTByTUN4j++R1Ur9sCT44c1A
	/C6j0zSqbidknJ0pyqxOYeHyIvwtOJcJOfyJ++OCq0TJTw5Q==
X-Google-Smtp-Source: AGHT+IFvXZEQLFBWJXoWj4mJGF2Z3vEqlg+8xryGG1dnbNbyx8bnU4qwIxsnj2FIbfYmbqf2RBl6Og==
X-Received: by 2002:a17:907:7205:b0:b71:60a3:a8b9 with SMTP id a640c23a62f3a-b72d0af76c9mr119381766b.29.1762509955891;
        Fri, 07 Nov 2025 02:05:55 -0800 (PST)
Received: from localhost.localdomain ([176.221.203.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa112a0sm203914966b.71.2025.11.07.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:05:55 -0800 (PST)
From: Jascha Sundaresan <flizarthanon@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jascha Sundaresan <flizarthanon@gmail.com>
Subject: Re: [PATCH v2] nvmem: layouts: u-boot-env: add optional "env-size" property
Date: Fri,  7 Nov 2025 14:05:29 +0400
Message-Id: <20251107100529.1303-1-flizarthanon@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251022230740.200742-1-flizarthanon@gmail.com>
References: <20251022230740.200742-1-flizarthanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Srinivas,

Friendly ping on this patch. Rob Herring reviewed it on Oct 26.
Are you planning to pick it up for the nvmem tree, or would you like me to resend?

Thanks,
Jascha

