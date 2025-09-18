Return-Path: <linux-kernel+bounces-822092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA5B83016
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1225C3B0084
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956628850B;
	Thu, 18 Sep 2025 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTMtazp4"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64D29BDBC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172989; cv=none; b=Xf/skOqUxPmsviLusZPAe8iyTpqznsmOhQv4iUHWlbHLncgBywWtrTxZG75n3hcUNACpwhWVPYSY35MIqi/qX4EiB0ePXJHwbha9obl0l9kAtMBAYG7leFJYZhbqF4//qDPg7YsPWTjNFAFqv7ghBDPkb/TXv7l1GIsZ4Ad/jP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172989; c=relaxed/simple;
	bh=TLOVWO8z3YKEVC/nG7+rCJR0ydpCskrgzD5ovtmPwE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrttBMQGz3rrZAnteK/n/51P+Q5QWztb6I3aLIH0jC2ZyGstF/s3AcJ30wvvbvwJDd/saYo3tbeiuGXl+Gqic9Yg++6uNSJ16g9djKe7F3dcdv2mK5zy3VYVYYKcdznniuKCvjnGbRwzXwKRBUph9ravDFQZP7+U+kz6zHNhVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTMtazp4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5503438189so153695a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172987; x=1758777787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLOVWO8z3YKEVC/nG7+rCJR0ydpCskrgzD5ovtmPwE0=;
        b=UTMtazp4XYHPTLcZ0zHHCcpO0xHIRSB2lMJPxIoGzrvIt9EoD96ld88ffOtZgirzuD
         ZD5KbZbNZ9a/L2mqKGWCHxw22nWAy/BwQYf69/jnVi7F764hg+b3pOCU4aP6e9oOkNMw
         cmhR/HBpzMnsq1Nweon1AxOgBvXoWtxUy3msrsuKeGYbVLA5cD++CM9tg+Zt3bg2ajHc
         XspbdBSW97T/9Ef1jzffWN4ZwzX1vQJBHe7WNzDScnJISR0AkO4TlyLozbZ+pkxZE2Re
         VmQBX7wt/fjsmIyFlNYk25ZSPXyvoIDlXGzx1xthR9h8NT9IBPWhZmjQ2HFZRs5oDnkx
         RtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172987; x=1758777787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLOVWO8z3YKEVC/nG7+rCJR0ydpCskrgzD5ovtmPwE0=;
        b=MtGECNyHC7NdYlb7bGZsAWHLwAO/SvGJQfzNxQyvUFe05ocVhmljIJCfY4NKBgiCIy
         lRAUguHKu4Z5jlKM4y7zQ1/oerHrW3lRkao59zm53GvvEgYdi1OtttZWxbxgS/AbxFaG
         /4uhmF4SAOcMrl7rwTORpZXClYQ4tmeeGVySATdyOIqVBe5mLzjvporUymwJxv9wHg6M
         w3XrXhTyJE7hCc3iJGnMfs6MiHIG3XbJddN9WXXTPno4xr6oUWVyjW18nKAoBiwpfwqT
         fMKu1nz+jkwSMyuGRRVvuyy46m8jBuklzmVHecbx31GeJnmkLWYdnSZz004BI3k90sRi
         2suA==
X-Forwarded-Encrypted: i=1; AJvYcCUxIYDOqbKaTUJrz5W2qHrAt5ZTY2vti6i+iqQpwb2xnB6xT87zh7SVFcvdXomKpo+IWqdKzaRg/k+b0Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCM8WGoo2ZtLeX/yVYok+DHYPFfAgbOlxKIceU7/7qa4jBDwC7
	RjPPg2maEZrGaSrqK8MWwc6UHTnOr7a/Eg6HMp894rxnaQUUtR0sahji
X-Gm-Gg: ASbGncsKk5zpeYGbtIpw8mzcajrNlndz6QgRUuQ/Zgo+jhS6K2uTAYPGVdQfWnw0ODy
	nG+r2kOZ7hF+8RaWrW1m53VjI48LNE6SFFCBe2QI2mHXrSFNAzW+rWSSwl420UBbmgjZF1HUFcT
	SIAzoeD21LyA2ZMQquZtzQxqYB1mHC7QoJ2GXPhgRYrC/dNM7YupIstDEEUmNAtr4GLCyP5HEla
	NiBy/xna6xHBZsEHpNTWNUyz/E1dXxbH81z3hTHAisWbcjGHhUy7xfBKg0n9LW/rt6YG0a/tWLf
	/lmj317EwK2aKlHGX7zK/npyiV0OPsw17L0zD1yjOzxyUO4qGOtQDbQX1XXMy1dVtTCCKLMt3DE
	J5BfUPHhsXTpsyxjXiJ29qCNUXnvLE59OEbl6Y2MJUuITaRqk+WfsjkhZm/Htw2S7
X-Google-Smtp-Source: AGHT+IHrJelkeadXxxJ309pMmd78F2SZWNn8q0FOA+TBRg4iz1HVjQgFNx8SwnfeBgb2w12a3cnNUQ==
X-Received: by 2002:a17:90b:4ccb:b0:32b:6820:6509 with SMTP id 98e67ed59e1d1-32ee3ef0a33mr5635940a91.9.1758172987275;
        Wed, 17 Sep 2025 22:23:07 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([49.249.92.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ec9e66b02sm2118449a91.10.2025.09.17.22.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:23:07 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	tessolveupstream@gmail.com,
	tingweiz@qti.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for QCS615 talos evk board
Date: Thu, 18 Sep 2025 10:53:01 +0530
Message-Id: <20250918052301.2583623-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f3y4ibzkyfdub6gszoliaenuiudfrtqfr5u4zqpibfdr44hr7l@z5ap4odsoiti>
References: <f3y4ibzkyfdub6gszoliaenuiudfrtqfr5u4zqpibfdr44hr7l@z5ap4odsoiti>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the suggestion.

Sure, I will update the commit message in v2 to mention
that the QCS615 talos-evk uses a Quectel AF68E module
(PCIe for WiFi and UART for Bluetooth), which is
different from the RIDE platform.

