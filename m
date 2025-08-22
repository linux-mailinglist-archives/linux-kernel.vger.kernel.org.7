Return-Path: <linux-kernel+bounces-781231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD00B30F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3288B587F21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC92E54D0;
	Fri, 22 Aug 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MX/sGEZf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C462E3AEA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845432; cv=none; b=rLjlj4EpnK23tRXOItSfESk3yDlgDbCw+6Yr6fH1YNfn2tByQ7EBugoU7bvc7fCTXEQ0kO2QWXkCcqgk/fuQaXHlhpZiyE5hu44deJgZSJVMK1o0IkRF7qs4YLyG4pRMxF85k/IQGZIvOe7b2LgxL+AFVWOHBz/4nEG4nKiofW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845432; c=relaxed/simple;
	bh=DuqjwUZ0I0wbqeZg4eSLBetmOHd1tcp0S+RZur3J6SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKHmNMoFaouCOUwwvCTv08OXcyJ5t5YSz/ZX7ASmgQwzPeSDIyn/2Iu94+Pqxxskfz2MovgkejqoxOt/jS8vsMwCFhxYLRXxttO9r4TcYTC3le5i3dLPpRwLtspGdHhUFgs/tA+HrpnUl46LWP9pin6+WhbZVX7ZcwNZEbJx/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MX/sGEZf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24456ce0b96so18749955ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755845430; x=1756450230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac9oBg+zAj6kXtu216Jjjabie+kjofFUW2rsHnH5Bqk=;
        b=MX/sGEZfNy9iQcvjl7FFBF1vsjt8G6QeSkTRRHFyMssJtFS3fwWqYNAB4hqoi7wnil
         /ePRZXcTc4PPbpNcazpUzo3T9llgN5AXyyG3lo4buW0/UE5HxJxNZqGrgt83KKhCM66V
         1OUrvBF7EwH5HNXZcWer4EGeaVvBZ1NvQXjFDZynTrCEr7M7pYjbQTdMjVBkVDCCEZ42
         o26jdkQnQDDe8RhdGJP0y2ekKfMIvmI/KszLzrmDP02WfHDbC//yl3R0gY1Cf7OAvxsJ
         zuEys1rTKqi8BMyazR8gG7bRZyekxK7kxeWPdUVYEpFhzK7OdhcDcFpSg6GhhSAkbHnm
         uA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845430; x=1756450230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac9oBg+zAj6kXtu216Jjjabie+kjofFUW2rsHnH5Bqk=;
        b=pZmXZtqC8f8Q0/3F4MvC9LCaOsZrSjDzzQxAnp+4TfQ3rTEh90P8cmCAOMO/PBJu9X
         4zDRqzzS2C5ZSuj4sH0ly17UUKb/AMEs6OZPanCoGR2aA0hm59uTV7bJwSk63rA/i7qe
         gUYuNNEmbfyHIwHU/rL3ta6WaOsvrrQZb8HeByNKctoukR6eq2X3iBKEgGK1NbNcG4vp
         WgTfNY6V+ZX5XrPMbD43MNDDElCwkVxDZKPT4vGhYuGL4rGAePyTAdPV6od+yLoXjKLL
         cnoRzMVs6jnR6U3CasyMqcm1zgixaJgF7Jgn/MgkXnGQF67e6lwFnLKCLjiBcRvv9mUc
         yZYw==
X-Forwarded-Encrypted: i=1; AJvYcCXJVed/Qg48AjG/SXY+yi4u95pCkOnES+U+V3K6vT+rynGGPL5xir9KDX1zE9U5O4oe/k1CcR9i3h/RNQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6A99CzL1Nj3rj/UcZaedUZioArTXytTAIvvdKlu/ynJ1HCWf
	F53kzKuZf0BcJMFU6p0iXNIIpFkuklxNsQ8jAQGGrGA0+fRI9R59CDU3dNRyEimEJnc=
X-Gm-Gg: ASbGncsNM/pTWzP12nO+EIzjqwkJIR2lMm8Y0ZTU7wN5oIuqjTbQ/aMrCKNNeGKV1z2
	L3Rmk8pQKd2bZ3VDyQmUo6Uxc6vYVDt47o6JBWrxA5qDgktAGyXlEUNwBMNsk5OhpMxrd20NrT5
	AuhlBXPFkUwYT1tnAnuK47nJ5/gc1jd9SEgwy7v6iU12VIoSv3BdrXGHetkvw0mN6NaeLCB39o8
	S3GulK2MGOgiNeIKKFre7Fv65HJWAahGHaj3mIWiYpT9eDegg4/nHB3mvkSxesyXS0iEZ1qDVa4
	YeSPH/4n1urFhhYM0B1U1TwA8ZjPJRVQRxFiaWgsPhjlKm1E6JSSiP21zYHACDnKiEwmUmsLSdj
	jdGFBoGO3nWmUkAESjaVv2n+7
X-Google-Smtp-Source: AGHT+IHgwZxe9A1mdJuJEAilKFh6/5WCjKikIYsvxCBNTe/vWqdxRw/EgUKt2pMsNi1wJJYtqOnVBA==
X-Received: by 2002:a17:902:e888:b0:240:4d19:8774 with SMTP id d9443c01a7336-24633d6a31amr23345995ad.24.1755845429661;
        Thu, 21 Aug 2025 23:50:29 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33df68sm74340735ad.21.2025.08.21.23.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:50:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:20:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/7] OPP: Add support to find OPP for a set of keys
Message-ID: <20250822065026.2ve2uscdjfismm7v@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-1-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-opp_pcie-v4-1-273b8944eed0@oss.qualcomm.com>

On 20-08-25, 13:58, Krishna Chaitanya Chundru wrote:
> Some clients, such as PCIe, may operate at the same clock frequency
> across different data rates by varying link width. In such cases,
> frequency alone is not sufficient to uniquely identify an OPP.
> To support these scenarios, introduce a new API
> dev_pm_opp_find_key_exact() that allows OPP lookup with different
> set of keys like freq, level & bandwidth.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/opp/core.c     | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 30 ++++++++++++++++
>  2 files changed, 127 insertions(+)

Applied with this diff:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a36c3daac39c..bba4f7daff8c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -476,7 +476,8 @@ static unsigned long _read_bw(struct dev_pm_opp *opp, int index)
        return opp->bandwidth[index].peak;
 }

-static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index, struct dev_pm_opp_key *key)
+static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index,
+                                  struct dev_pm_opp_key *key)
 {
        key->bw = opp->bandwidth ? opp->bandwidth[index].peak : 0;
        key->freq = opp->rates[index];
@@ -518,12 +519,13 @@ static bool _compare_floor(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
        return false;
 }

-static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
-                                  struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
+static bool _compare_opp_key_exact(struct dev_pm_opp **opp,
+               struct dev_pm_opp *temp_opp, struct dev_pm_opp_key *opp_key,
+               struct dev_pm_opp_key *key)
 {
-       bool level_match = (key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
-       bool freq_match = (key.freq == 0 || opp_key.freq == key.freq);
-       bool bw_match = (key.bw == 0 || opp_key.bw == key.bw);
+       bool level_match = (key->level == OPP_LEVEL_UNSET || opp_key->level == key->level);
+       bool freq_match = (key->freq == 0 || opp_key->freq == key->freq);
+       bool bw_match = (key->bw == 0 || opp_key->bw == key->bw);

        if (freq_match && level_match && bw_match) {
                *opp = temp_opp;
@@ -570,7 +572,7 @@ static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
                unsigned long (*read)(struct dev_pm_opp *opp, int index,
                                      struct dev_pm_opp_key *key),
                bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
-                               struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key),
+                               struct dev_pm_opp_key *opp_key, struct dev_pm_opp_key *key),
                bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
        struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
@@ -585,9 +587,8 @@ static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
                if (temp_opp->available == available) {
                        read(temp_opp, 0, &temp_key);
-                       if (compare(&opp, temp_opp, temp_key, *key)) {
+                       if (compare(&opp, temp_opp, &temp_key, key)) {
                                /* Increment the reference count of OPP */
-                               *key = temp_key;
                                dev_pm_opp_get(opp);
                                break;
                        }
@@ -689,20 +690,20 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);

 /**
- * dev_pm_opp_find_key_exact() - Search for an exact OPP key
- * @dev:                Device for which the OPP is being searched
- * @key:                OPP key to match
- * @available:          true/false - match for available OPP
+ * dev_pm_opp_find_key_exact() - Search for an OPP with exact key set
+ * @dev:               Device for which the OPP is being searched
+ * @key:               OPP key set to match
+ * @available:         true/false - match for available OPP
  *
- * Search for an exact match the OPP key in the OPP table.
+ * Search for an exact match of the key set in the OPP table.
  *
- * Return: matching *opp, else returns ERR_PTR in case of error and should
- * be using IS_ERR. Error return values can be:
- * EINVAL:      for bad pointer
- * ERANGE:      no match found for search
- * ENODEV:      if device not found in list of registered devices
+ * Return: A matching opp on success, else ERR_PTR in case of error.
+ * Possible error values:
+ * EINVAL:     for bad pointers
+ * ERANGE:     no match found for search
+ * ENODEV:     if device not found in list of registered devices
  *
- * Note: 'available' is a modifier for the search. If 'available'=true,
+ * Note: 'available' is a modifier for the search. If 'available' == true,
  * then the match is for exact matching key and is available in the stored
  * OPP table. If false, the match is for exact key which is not available.
  *
@@ -713,7 +714,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
  * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
-                                            struct dev_pm_opp_key key,
+                                            struct dev_pm_opp_key *key,
                                             bool available)
 {
        struct opp_table *opp_table __free(put_opp_table) = _find_opp_table(dev);
@@ -724,8 +725,9 @@ struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
                return ERR_CAST(opp_table);
        }

-       return _opp_table_find_opp_key(opp_table, &key, available, _read_opp_key,
-                                      _compare_opp_key_exact, assert_single_clk);
+       return _opp_table_find_opp_key(opp_table, key, available,
+                                      _read_opp_key, _compare_opp_key_exact,
+                                      assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_key_exact);

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d244bf97489..789406d95e69 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -151,7 +151,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
                                              bool available);

 struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
-                                            struct dev_pm_opp_key key,
+                                            struct dev_pm_opp_key *key,
                                             bool available);

 struct dev_pm_opp *
@@ -313,7 +313,7 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }

 static inline struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
-                                                          struct dev_pm_opp_key key,
+                                                          struct dev_pm_opp_key *key,
                                                           bool available)
 {
        return ERR_PTR(-EOPNOTSUPP);

-- 
viresh

