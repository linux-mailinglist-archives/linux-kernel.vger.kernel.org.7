Return-Path: <linux-kernel+bounces-842030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A84BB8CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54553A9FB0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E67226E71D;
	Sat,  4 Oct 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmQ7Hot2"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35322175BF
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578335; cv=none; b=fPJLdKNvHlxIbAito+L7GQkbygG5K5lND915/lmtWULOORDVRr8lJiRjtp7LqrS0e25s3k41D1GW0g4KMSNSyOHxSEbVlxPUtxveEktxtuHLz6HP2xgLKxx+dnI6s5x3wamtKPY8pDNlJG66txQQ+blqmqjF6MTqgZ/AWH7XSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578335; c=relaxed/simple;
	bh=uLDk2OG5CoYAD8IAicYACisYmTIWk3ECt7xlbolSSC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CJ2SVhn/+rchKRrEB1hx1B1XA1FQRYlEMdtQ8HyH43Kx8qfZsOhXsS1gJwEWdKIpA82bRWq8zR56xvKFup1SFZ28oQXWWZ+aynxCW6aMEefkwrxNM5IENTpMTAuZODsE0CSgWaNbV7X/lti+ZEMs7MbrpECf88QV6eXZrKMgASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmQ7Hot2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-279e2554b6fso22049435ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759578333; x=1760183133; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjoO0UAP8wLhOsBJOjJbYwG45v8R3yCdSlhLiVi5GKk=;
        b=BmQ7Hot2M1F1AGirrEpUOfk/YMvPZiG4qV98YvEe2WnB19/jhaFJcxyyjR5F6XLfim
         PKJta+Bhc7xLsijJy61BZ4uuz5SkrPhARQu87Tzhfcyh0BI6NBuyqXrvWc+7LBWofVq5
         ElxusasYvNGrC1CDKFk2+uzMVlyJlS8FtgrK4bOy7pVTuog+9ULTjf3uulC+uSrCAHyR
         QWilJtpJOfW3NHbCJEgbmtIYBL9UkyMoAeme+8d43+PuWMQVcRDM3ZG6xW/XKtxXjstS
         k0yuVCW88Gjzy1+PQrm+e3FlBmU3xVw+W6HiztM/lYC3AvzZP6jN2syTQFbFpJYLU04x
         uACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759578333; x=1760183133;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LjoO0UAP8wLhOsBJOjJbYwG45v8R3yCdSlhLiVi5GKk=;
        b=rjtgqr7fuGH6h1I+S/SWAC/D7wrK5irU+5APTALpWwnoL5HMCViZdXvD1zHi08lEpU
         Us8hX+azwoLauMfuglihb7JbKl2vKgNJFFJsNaFIp0A3l5ZBgbSVX62nFvId85ryopjb
         JFdgKvwQxWn/OcUdb5PKij9AHc3rVreDYf1XQD8hvjy51ztiMTNMXUKwzTIyvDw0rADa
         9hAz5z6M0YwhfhLiRxWKFy/nONHf6bvkiSuHpH9V2llTccO5+54vC5upOnH88oqOsrZH
         PA8/etiqzFS92n5c6KFUoTZDdV4LIQyoq8Pap4pqi29k7mUVfbdFibj0Z9o49yzzzmts
         afvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVruqcgCYTMtmcWaQiW/+sEW0BLQ1e96BHQP7ntW8xUzHumL7rzCk6Db7naFTRdKw4t2IEQcLTuxOHkzoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2wrAfxyKMASIA9pfa5DE/qgs7lknXrx0tz7q4lhWOQkzpEYF
	lF/0ysKvfUkw5Vf59XIuYN7iKP4Bm0E70I7uLkBYgrwvGMIFgKvnCm1M
X-Gm-Gg: ASbGnctkVjm0Kz0rjU0ggUbvDYpR+p94K/AJJ3KI3VaTjiwwz/1qYeL5TQOaoKXlX0D
	J+c8Gcy2Li2JfnEPgnQS5JqM/xbtgfkF2nL58bY9Zy/Y5aZxz0elSBC8+ZnImvZt6GARlCohj5b
	VpXCiczwcnQQJvS48Nyr4Hm02vdcMEkSF6g/k9gl9Aa4HSEEQ9u/07pHYbN9/WGhfF7emNT4jGS
	bh4AjA0yDMICYJ16ol6k8UMRv0iXYBjoeFjNYJUyQba+8q+xDGdlQoLu2PTQQRD92YdHx899wXx
	b5KUNpkLjgp7hyxFnHNIhYPd44B9bYg+GbTf95KU09WtDc3cqjn4xiH7zgmyD1JNrvlpu8Ryb2Y
	S6NPWOrQW3wS0gcjMQ7m4VIGSAyCRpHnDpwPnx0gKmMgJsG1079xnWA==
X-Google-Smtp-Source: AGHT+IGwxuikndPwINebsmYQWlErDERFXYfdpKK/Vy/UR1eaJP/QxN4HgRPLWp92ywO3Mucwrrd+ug==
X-Received: by 2002:a17:903:1b25:b0:28e:756c:7082 with SMTP id d9443c01a7336-28e9a546d94mr75264205ad.15.1759578333361;
        Sat, 04 Oct 2025 04:45:33 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1269b8sm77029755ad.50.2025.10.04.04.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 04:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Oct 2025 20:45:29 +0900
Message-Id: <DD9IGL9UOYQO.2E59VYAPO8DLN@gmail.com>
Subject: Re: [PATCH net] net: dlink: use dev_kfree_skb_any instead of
 dev_kfree_skb
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251003022300.1105-1-yyyynoom@gmail.com>
 <20251003081729.GB2878334@horms.kernel.org>
 <DD8MONMKM9ZD.1PT79LGCA7U06@gmail.com>
 <20251004095421.GC3060232@horms.kernel.org>
In-Reply-To: <20251004095421.GC3060232@horms.kernel.org>

On Sat Oct 4, 2025 at 6:54 PM KST, Simon Horman wrote:
>
> Hi Yeounsu,
>
> Thanks for your detailed response.
I also appreciate your review :)
>
> I do think it would be useful to add something like this to the commit
> message:
>
>   Found by inspection.
>
After re-reading both your previous reply and my commit message, I can
see how question could arise. And I realize that I should have provided
a more convincing commit message, but I failed to do so.
Next time, I will make sure to include not only what you suggested but
also a more detailed commit message overall.

	Yeounsu Moon

