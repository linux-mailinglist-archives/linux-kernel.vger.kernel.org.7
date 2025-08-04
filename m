Return-Path: <linux-kernel+bounces-754739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A4B19BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCF43AA54F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FA229B12;
	Mon,  4 Aug 2025 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyA8WX+o"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2686EC2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289426; cv=none; b=V/S1FztXsZKLdKTDKPAzNgzfsDq+Zzbkpp04oVOt6Hl2M/YPEliRItMJhNSIpkQKrK4TlEZ/0ld6JQ/FSkvKm+SNFM6vuboaeq9AjL8ROdQgCeFOQ1vamVrbSPvFWekQWTZda1j+Yo8bi0zE8F3aqUY6RL/EnZYOkjCZi+/SymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289426; c=relaxed/simple;
	bh=cWo+1+KQavKfFSEibhqQKO3SVD0lpoErOf3vNT7vPCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Onr8MEiZKi023fqqVDEjnSx/BL8KvzgPTrmwS43Is7HQBQot5dmweYJA8GCABin9o58li8orSuWlqavIKt6RzD1avb74MkX6HMyh2959Av3Rph7tmIWQgqMJLnG6cJXh+y+XjXQStHubdGA8D55/bMEMJ+WoF5ICFp3o3Y2y+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fyA8WX+o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so13682465e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754289423; x=1754894223; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMqOordL6fYAlMra8g6TRkHlEFJWMTo9GYxxpxwalRg=;
        b=fyA8WX+oob91XHIhRF6s1g+ceRVCAaDmO6vj8FQHyrDHBQCLcNxkIm9daHbTQwV3kz
         IlDLx+RmensvLV97J5OCjsUgMTCVFznfogz6SuSlT5wjzg2lRBSkzFPC65kyTlfL060Y
         UiPeHXB02uxPD5vG1thQnnxJDdN6SIe5Af3+mgF0YceVIOJR6FzL3PM4srjtRUffD6iH
         xHwREjW2eCrkCgEk5JT3mHYAtpXdTBGtFo5eW/yVm0Q1fTazVYkik76eSPTZzLinEn7V
         8xJgDWGnSOchflOImPYuTP/hAFd9xdEwjJyYnr2TzubokMhTUXslkusGmWD+SxhsHUmF
         xVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754289423; x=1754894223;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMqOordL6fYAlMra8g6TRkHlEFJWMTo9GYxxpxwalRg=;
        b=NIDgOz6Gpw1TkY/rjiYkptWFSP2uazz5arWpa5Lt4h46JtgBzvG2nlcjAH66bi5RP2
         ORJpfdUBf3NoLwygO30/+vv7c0wm7KGnay4kJ1xvotW4HiwnQFJv/INm7LRmv9gAQZxm
         cWcB3RGV2MWZi+CImH+7Kt0a3kYD7QNCRgigHl1PhibsGbFXdoeTGSxeZ5xQeRKR/9I8
         RxNfMcPf3hyHKU7J+aDur8612nGN/FhIMQuYpZvlaWWq9rbiCP9LfrvGPuYAsQXVlSX6
         C3xyN31zscrQTdBIc5eTefMmTl0nJpEMy/8QCPBqVBy93Yne/TAOKBn7W1m6o0uEZhqg
         miPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJkflB8WqqVaOal1NbmAcHCbh/Qbj4wecydYsif1fHtaf1hsP3TPQHP/7SNedhFQaR61lZSblwosa2YR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TGr2U5O8Sm34RBepgcGI1po7HFvXcHZ2MwBtpMvmcabuBRu5
	nED9LQB43SoFM4IpnyhSyytS/my9vLMUlyt9AK1Q8o/6t/cUbrhblxUqzE3wKMiX0LM=
X-Gm-Gg: ASbGncsml++hSz5kCcgCBptwsqgZDjoiZDnAJNBfBD/x7BcuOG/fYOKgbJrSQVQWljg
	b8i4wtvBS+4xmMFzvrq203d+xcfE7pgmWAmxQVuqB4k1140hcGcgeBhhIK4pZWKXWmOvekrphKP
	gEVqoPz0NvMVBHJpoIBXsEkHn/g9evz7Y0JYvBZham3TfzB9dP1eQTFdjk++/BCVtaCtXJk7+uc
	1ZO3pNCrZdKVUV8yhoGmBt2alWAr/6U5DpXTQGU2zsoBkcDrCTUPt91gtNoID/I97kbfVAyuin7
	R+qTDpFlDRooF2AREX3lYCq1162TboJIobkcDXvVzxCX61fQM5o/1lOEAA4pgt20/YfXcma+OZj
	VIgxF99La4MflKPgRW+w2nQotsR8=
X-Google-Smtp-Source: AGHT+IGEvRyryD7ili35wNADk5uvsbVaFZNVwOw1rvSQfa0XkjNQ7ywk15aPbVYA/1Mh9Vh+0rwX2Q==
X-Received: by 2002:a05:600c:1554:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-458b6b58472mr67261065e9.18.1754289422884;
        Sun, 03 Aug 2025 23:37:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bb04c612sm76259555e9.0.2025.08.03.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:37:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:36:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2093
 iwl_mld_set_key_add() error: we previously assumed 'mld_sta' could be null
 (see line 2076)
Message-ID: <8bf5e723-f70f-4767-8d8e-476143c962c3@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   186f3edfdd41f2ae87fc40a9ccba52a3bf930994
commit: d1e879ec600f9b3bdd253167533959facfefb17b wifi: iwlwifi: add iwlmld sub-driver
config: i386-randconfig-141-20250803 (https://download.01.org/0day-ci/archive/20250803/202508031151.K87baMm4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508031151.K87baMm4-lkp@intel.com/

smatch warnings:
drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2093 iwl_mld_set_key_add() error: we previously assumed 'mld_sta' could be null (see line 2076)
drivers/net/wireless/intel/iwlwifi/mld/scan.c:1124 iwl_mld_scan_cmd_set_chan_params() warn: assigning (-128) to unsigned variable 'cfg->v5.psd_20'
drivers/net/wireless/intel/iwlwifi/mld/ptp.c:298 iwl_mld_ptp_init() warn: passing zero to 'PTR_ERR'
   The IS_ERR_OR_NULL() check should be changed to IS_ERR().  See
   https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
   for more details.

vim +/mld_sta +2093 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c

d1e879ec600f9b Miri Korenblit 2025-02-16  2024  static int iwl_mld_set_key_add(struct iwl_mld *mld,
d1e879ec600f9b Miri Korenblit 2025-02-16  2025  			       struct ieee80211_vif *vif,
d1e879ec600f9b Miri Korenblit 2025-02-16  2026  			       struct ieee80211_sta *sta,
d1e879ec600f9b Miri Korenblit 2025-02-16  2027  			       struct ieee80211_key_conf *key)
d1e879ec600f9b Miri Korenblit 2025-02-16  2028  {
d1e879ec600f9b Miri Korenblit 2025-02-16  2029  	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
d1e879ec600f9b Miri Korenblit 2025-02-16  2030  	struct iwl_mld_sta *mld_sta =
d1e879ec600f9b Miri Korenblit 2025-02-16  2031  		sta ? iwl_mld_sta_from_mac80211(sta) : NULL;
                                                                                                       ^^^^

d1e879ec600f9b Miri Korenblit 2025-02-16  2032  	struct iwl_mld_ptk_pn *ptk_pn = NULL;
d1e879ec600f9b Miri Korenblit 2025-02-16  2033  	int keyidx = key->keyidx;
d1e879ec600f9b Miri Korenblit 2025-02-16  2034  	int ret;
d1e879ec600f9b Miri Korenblit 2025-02-16  2035  
d1e879ec600f9b Miri Korenblit 2025-02-16  2036  	/* Will be set to 0 if added successfully */
d1e879ec600f9b Miri Korenblit 2025-02-16  2037  	key->hw_key_idx = STA_KEY_IDX_INVALID;
d1e879ec600f9b Miri Korenblit 2025-02-16  2038  
d1e879ec600f9b Miri Korenblit 2025-02-16  2039  	switch (key->cipher) {
d1e879ec600f9b Miri Korenblit 2025-02-16  2040  	case WLAN_CIPHER_SUITE_WEP40:
d1e879ec600f9b Miri Korenblit 2025-02-16  2041  	case WLAN_CIPHER_SUITE_WEP104:
d1e879ec600f9b Miri Korenblit 2025-02-16  2042  		IWL_DEBUG_MAC80211(mld, "Use SW encryption for WEP\n");
d1e879ec600f9b Miri Korenblit 2025-02-16  2043  		return -EOPNOTSUPP;
d1e879ec600f9b Miri Korenblit 2025-02-16  2044  	case WLAN_CIPHER_SUITE_TKIP:
d1e879ec600f9b Miri Korenblit 2025-02-16  2045  		if (vif->type == NL80211_IFTYPE_STATION) {
d1e879ec600f9b Miri Korenblit 2025-02-16  2046  			key->flags |= IEEE80211_KEY_FLAG_PUT_MIC_SPACE;
d1e879ec600f9b Miri Korenblit 2025-02-16  2047  			break;
d1e879ec600f9b Miri Korenblit 2025-02-16  2048  		}
d1e879ec600f9b Miri Korenblit 2025-02-16  2049  		IWL_DEBUG_MAC80211(mld, "Use SW encryption for TKIP\n");
d1e879ec600f9b Miri Korenblit 2025-02-16  2050  		return -EOPNOTSUPP;
d1e879ec600f9b Miri Korenblit 2025-02-16  2051  	case WLAN_CIPHER_SUITE_CCMP:
d1e879ec600f9b Miri Korenblit 2025-02-16  2052  	case WLAN_CIPHER_SUITE_GCMP:
d1e879ec600f9b Miri Korenblit 2025-02-16  2053  	case WLAN_CIPHER_SUITE_GCMP_256:
d1e879ec600f9b Miri Korenblit 2025-02-16  2054  	case WLAN_CIPHER_SUITE_AES_CMAC:
d1e879ec600f9b Miri Korenblit 2025-02-16  2055  	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
d1e879ec600f9b Miri Korenblit 2025-02-16  2056  	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
d1e879ec600f9b Miri Korenblit 2025-02-16  2057  		break;
d1e879ec600f9b Miri Korenblit 2025-02-16  2058  	default:
d1e879ec600f9b Miri Korenblit 2025-02-16  2059  		return -EOPNOTSUPP;
d1e879ec600f9b Miri Korenblit 2025-02-16  2060  	}
d1e879ec600f9b Miri Korenblit 2025-02-16  2061  
d1e879ec600f9b Miri Korenblit 2025-02-16  2062  	if (vif->type == NL80211_IFTYPE_STATION &&
d1e879ec600f9b Miri Korenblit 2025-02-16  2063  	    (keyidx == 6 || keyidx == 7))
d1e879ec600f9b Miri Korenblit 2025-02-16  2064  		rcu_assign_pointer(mld_vif->bigtks[keyidx - 6], key);
d1e879ec600f9b Miri Korenblit 2025-02-16  2065  
d1e879ec600f9b Miri Korenblit 2025-02-16  2066  	/* After exiting from RFKILL, hostapd configures GTK/ITGK before the
d1e879ec600f9b Miri Korenblit 2025-02-16  2067  	 * AP is started, but those keys can't be sent to the FW before the
d1e879ec600f9b Miri Korenblit 2025-02-16  2068  	 * MCAST/BCAST STAs are added to it (which happens upon AP start).
d1e879ec600f9b Miri Korenblit 2025-02-16  2069  	 * Store it here to be sent later when the AP is started.
d1e879ec600f9b Miri Korenblit 2025-02-16  2070  	 */
d1e879ec600f9b Miri Korenblit 2025-02-16  2071  	if ((vif->type == NL80211_IFTYPE_ADHOC ||
d1e879ec600f9b Miri Korenblit 2025-02-16  2072  	     vif->type == NL80211_IFTYPE_AP) && !sta &&
d1e879ec600f9b Miri Korenblit 2025-02-16  2073  	     !mld_vif->ap_ibss_active)
d1e879ec600f9b Miri Korenblit 2025-02-16  2074  		return iwl_mld_store_ap_early_key(mld, key, mld_vif);
d1e879ec600f9b Miri Korenblit 2025-02-16  2075  
d1e879ec600f9b Miri Korenblit 2025-02-16 @2076  	if (!mld->fw_status.in_hw_restart && mld_sta &&
                                                                                             ^^^^^^^
This code assumes that mld_sta can be NULL

d1e879ec600f9b Miri Korenblit 2025-02-16  2077  	    key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
d1e879ec600f9b Miri Korenblit 2025-02-16  2078  	    (key->cipher == WLAN_CIPHER_SUITE_CCMP ||
d1e879ec600f9b Miri Korenblit 2025-02-16  2079  	     key->cipher == WLAN_CIPHER_SUITE_GCMP ||
d1e879ec600f9b Miri Korenblit 2025-02-16  2080  	     key->cipher == WLAN_CIPHER_SUITE_GCMP_256)) {
d1e879ec600f9b Miri Korenblit 2025-02-16  2081  		ret = iwl_mld_alloc_ptk_pn(mld, mld_sta, key, &ptk_pn);
d1e879ec600f9b Miri Korenblit 2025-02-16  2082  		if (ret)
d1e879ec600f9b Miri Korenblit 2025-02-16  2083  			return ret;
d1e879ec600f9b Miri Korenblit 2025-02-16  2084  	}
d1e879ec600f9b Miri Korenblit 2025-02-16  2085  
d1e879ec600f9b Miri Korenblit 2025-02-16  2086  	IWL_DEBUG_MAC80211(mld, "set hwcrypto key (sta:%pM, id:%d)\n",
d1e879ec600f9b Miri Korenblit 2025-02-16  2087  			   sta ? sta->addr : NULL, keyidx);
d1e879ec600f9b Miri Korenblit 2025-02-16  2088  
d1e879ec600f9b Miri Korenblit 2025-02-16  2089  	ret = iwl_mld_add_key(mld, vif, sta, key);
d1e879ec600f9b Miri Korenblit 2025-02-16  2090  	if (ret) {
d1e879ec600f9b Miri Korenblit 2025-02-16  2091  		IWL_WARN(mld, "set key failed (%d)\n", ret);
d1e879ec600f9b Miri Korenblit 2025-02-16  2092  		if (ptk_pn) {
d1e879ec600f9b Miri Korenblit 2025-02-16 @2093  			RCU_INIT_POINTER(mld_sta->ptk_pn[keyidx], NULL);
                                                                                         ^^^^^^^^^
But here it's dereferenced without checking.

d1e879ec600f9b Miri Korenblit 2025-02-16  2094  			kfree(ptk_pn);
d1e879ec600f9b Miri Korenblit 2025-02-16  2095  		}
d1e879ec600f9b Miri Korenblit 2025-02-16  2096  
d1e879ec600f9b Miri Korenblit 2025-02-16  2097  		return -EOPNOTSUPP;
d1e879ec600f9b Miri Korenblit 2025-02-16  2098  	}
d1e879ec600f9b Miri Korenblit 2025-02-16  2099  
d1e879ec600f9b Miri Korenblit 2025-02-16  2100  	return 0;
d1e879ec600f9b Miri Korenblit 2025-02-16  2101  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


